require_relative "../services/user_service"
require_relative "../services/log_service"

include UserService

class ApplicationController < ActionController::API
    include LogService

    before_action :set_user
    before_action :log_request
    after_action :log_response
    rescue_from ::StandardError, with: :error_handler


    def set_user
        user_id = session[:user_id]
        if user_id
            UserService::current_user = User.find_by_id user_id
        else
            UserService::current_user = nil
        end
    end

    def log_request
        log "#{$/}Request sent to '#{request.fullpath}':#{$/}\t#{params}#{$/}"

    end

    def log_response
        log "#{$/}Response sent from '#{request.fullpath}':#{$/}\t#{response.body}#{$/}"
    end

    def error_handler(exception)
        response = ApiResponse.new
        response.add_message exception.message
        stacktrace = exception.backtrace.join("#{$/}\t")
        response.add_message stacktrace
        log "{$/}{$/}Caught Exception:{$/}\t#{exception.to_s}{$/}\t#{exception.message}#{$/}#{stacktrace}{$/}{$/}"

        render json: response, status: :internal_server_error
    end

end
