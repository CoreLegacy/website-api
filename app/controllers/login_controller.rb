require_relative "./application_controller"

class LoginController < ApplicationController

    skip_before_action :authorize, only: [:create]

    def create
        params = user_params
        response = LoginResponse.new
        status = :ok

        email = params[:email]
        password = params[:password]
        with_auth_token = params[:with_auth_token]
        log params

        if !email || !password
            status = :bad_request
            response.is_successful = false
            response.add_message "Must provide a valid email and password"
        elsif UserService::authenticate email, password
            user = User.find_by(email: email)
            log "User authenticated: #{user.inspect}"
            expiry = Rails.application.config.JWT_EXPIRY.hours.from_now
            payload = { user_id: user.id, expiry: expiry }
            log "JWT Payload: #{payload}"
            auth_token = JwtService::encode(payload)
            if !with_auth_token
                cookies[:auth_token] = { value: auth_token }
            end

            user.auth_token = auth_token
            user.save

            if with_auth_token
                response.auth_token = auth_token
            end
            response.user = UserData.new(user)
            response.is_successful = true
        else
            response.is_successful = false
            response.add_message "Tried to log in but was unable to authenticate user."
        end

        render json: response, status: status
    end

    def destroy
        response = LogOutResponse.new

        user = UserService::current_user
        if user
            user.auth_token = nil
            user.save

            response.logged_out = true
            response.session_expired = self.session_expired
        end

        render json: response
    end

    private

    def user_params
        params.permit :user, :email, :password, :with_auth_token
    end

end