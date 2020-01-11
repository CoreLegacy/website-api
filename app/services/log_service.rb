module LogService
    include ActionView::Helpers::OutputSafetyHelper

    def log(log, pad_with_newlines = true)
        if log.is_a?(String) || log.is_a?(Numeric)
            if pad_with_newlines
                puts "#{$/}#{log}#{$/}"
            else
                puts log
            end
        else
            if pad_with_newlines
                puts "#{$/}#{log.inspect}{$/}"
            else
                puts log.inspect
            end
        end
    end

    def log_error(context)
        unless context.is_a? ExceptionContext
            exception_context = ExceptionContext.new
            exception_context.exception = context
            exception_context.message = "Unhandled Exception"
            exception_context.severity = ExceptionLog::CRITICAL

            log_error exception_context
            return
        end

        error_log = ExceptionLog.new
        error_log.log_message = context.message
        error_log.exception_message = context.exception.message if context.exception
        error_log.stacktrace = context.exception.backtrace.join("#{$/}\t")

        error_log.params = context.params.inspect if context.params
        if context.response
            error_log.response = context.response.inspect
            error_log.response_body = context.response.body
            error_log.raw_response = context.response.raw nil
        end
        if context.request
            error_log.request = context.request.inspect
            error_log.ip_address = context.request.remote_ip
            error_log.request_params = context.request.params
            error_log.raw_request = context.request.env
        end
        error_log.user_id = context.user.id if context.user
        error_log.token_payload = context.token_payload
        error_log.severity = context.severity ? context.severity : ExceptionLog::ERROR

        old_logger = ActiveRecord::Base.logger
        ActiveRecord::Base.logger = nil
        error_log.save
        error_log.save

        puts "#{$/}Caught Exception: '#{context.exception.to_s}'#{$/}\t#{error_log.exception_message}#{$/}#{error_log.stacktrace}#{$/}"
    end

    def timestamp
        "#{Time.new.strftime("%m-%d-%Y %H:%M:%S")}"
    end
end