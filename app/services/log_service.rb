module LogService

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

    def log_error(exception)
        stacktrace = exception.backtrace.join("#{$/}\t")
        puts "#{$/}Caught Exception: '#{exception.to_s}'#{$/}\t#{exception.message}#{$/}#{stacktrace}#{$/}"
    end

    def timestamp
        "#{Time.new.strftime("%m-%d-%Y %H:%M:%S")}"
    end
end