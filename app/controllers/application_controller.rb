require_relative "../services/user_service"
require_relative "../services/log_service"

class ApplicationController < ActionController::API
    include UserService
    include LogService

    before_action :set_user
    before_action :log_request
    after_action :log_response
    rescue_from ::StandardError, with: :error_handler


    def set_user
        user_id = session[:user_id]
        if user_id
            @current_user = User.find user_id
        else
            @current_user = nil
        end
        UserService.current_user = @current_user
    end

    def log_request
        LogService.log "Request to '#{request.fullpath}':#{$/}\t#{params}"

    end

    def log_response
        LogService.log "Response from '#{request.fullpath}':#{$/}\t#{response.body}"
    end

    def error_handler(exception)
        response = ApiResponse.new
        response.add_message exception.message
        stacktrace = exception.backtrace.join($/)
        response.add_message stacktrace
        LogService.log "#{exception.message}#{$/}#{stacktrace}"

        render json: response, status: :internal_server_error
    end

end
