require_relative "../services/user_service"
require_relative "../services/log_service"
require_relative '../../app/services/jwt_service'
require "jbuilder"

include UserService
include JWTService

class ApplicationController < ActionController::API
    include AbstractController::Helpers
    include ActionController::Cookies
    include ActionController::ImplicitRender
    include LogService

    before_action :set_user
    before_action :authorize
    before_action :log_request
    after_action :log_response
    after_action :cookie_inspect

    attr_reader :current_idle_time
    attr_reader :session_expired

    attr_reader :is_forbidden

    rescue_from ::StandardError, with: :error_handler

    def set_user
        log "Request headers from '#{request.fullpath}':", false
        response.headers.each do |header|
            log "\t#{header}", false
        end
        if cookies[:auth_token]
            log "Auth Cookie present, checking for JWT"
            process_auth_token cookies[:auth_token]
        elsif request.headers['Authorization'].present?
            log "Bearer Token present, checking for JWT"
            auth_token_raw = request.headers['Authorization'].split(' ').last
            process_auth_token auth_token_raw
        else
            log "Could not find Bearer Token or Auth Cookie"
            UserService::current_user = nil
        end
    end

    def authorize
        log "#{$/}#{$/}AUTHORIZATION BEGINNING#{$/}#{$/}"
        user = UserService::current_user
        if user
            auth_token = JWTService::decode user.auth_token
            # If user has idle too long or JWT has expired, redirect them to the logout action
            log "Auth Token: #{auth_token}", false
            expiry = auth_token[:expiry].to_time
            log "Expiration Time: #{expiry.inspect}#{$/}Current Time:    #{Time.now.inspect}"
            log "Current Idle Time: #{current_idle_time}#{$/}Idle Timeout:      #{Rails.application.config.IDLE_TIMEOUT}"
            if Time.now >= expiry || current_idle_time >= Rails.application.config.IDLE_TIMEOUT
                log "User's session has expired, redirecting to Log Out"
                @session_expired = true
                redirect_to "/logout"
            else
                log "User has been authenticated"
            end
        else
            log "Current user is nil"
            @is_forbidden = true
            raise "Auth token is invalid"
        end
    end

    def log_request
        log "#{timestamp}#{$/}Request sent to '#{request.fullpath}':#{$/}\t#{params}"
    end

    def log_response
        log "#{timestamp}#{$/}Response sent from '#{request.fullpath}':#{$/}\t#{response.body}"
    end

    def cookie_inspect
        log "Cookies:", false
        response.cookies.each do |cookie|
            log "\t#{cookie}", false
        end
    end

    def error_handler(exception)
        response = ApiResponse.new
        if Rails.env.production?
            response.add_message "A server error occurred. Contact an administrator if error continues."
        else
            response.add_message exception.message
            stacktrace = exception.backtrace.join("#{$/}\t")
            response.add_message stacktrace
        end

        status = @is_forbidden ? :forbidden : :internal_server_error

        log_error exception

        render json: response, status: status
    end

    def process_auth_token(auth_token_raw)
        log "Raw JWT: #{auth_token_raw}"
        auth_token = JWTService::decode auth_token_raw
        log "Decoded JWT: #{auth_token}"
        if auth_token
            now = Time.now
            user_id = auth_token[:user_id]
            user = User.find_by_id user_id
            if user
                log "User via Auth Token: #{user.inspect}"
                unless user.last_request_time
                    user.last_request_time = now
                end
                user.auth_token = auth_token_raw
                @current_idle_time = now - user.last_request_time
                user.last_request_time = now
                user.save

                log "User from auth token updated and saved."
                UserService::current_user = user
            else
                log "User with id #{user_id} from Auth token does not exist"
                UserService::current_user = nil
            end

        else
            log "Authorization header was present but contained no token."
            UserService::current_user = nil
        end
    end

end
