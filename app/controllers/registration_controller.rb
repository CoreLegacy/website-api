require_relative "./application_controller"
require_relative "../services/user_service"
require "securerandom"

include UserService

class RegistrationController < ApplicationController

    skip_before_action :authorize

    def get_user_by_reset_key
        params = user_params
        key = params[:key]

        password_reset_key_obj = PasswordResetKey.find_by reset_key: key
        user = User.find password_reset_key_obj.user_id
        response = UserResponse.new
        response.user = UserData.new user
        response.is_successful = true

        render json: response, status: :ok
    end

    def create
        params = user_params
        response = FlaggedResponse.new
        status = :ok
        with_auth_token = params[:with_auth_token]

        log "Creating user with auth token"

        response.add_message "Must provide email address" unless params[:email]
        response.add_message "Must provide passsword" unless params[:password]
        response.add_message "User with email address '#{params[:email]}' already exists" if User.find_by(email: params[:email])

        if response.messages.length === 0
            user = UserService::create params

            expiry = Rails.application.config.JWT_EXPIRY.hours.from_now
            payload = { user_id: user.id, expiry: expiry }
            log "JWT Payload: #{payload}"
            auth_token = JwtService::encode(payload)
            cookies[:auth_token] = { value: auth_token }

            DefaultMailer.with(user_id: user.id).welcome_email.deliver

            response = UserResponse.new
            if with_auth_token
                response.auth_token = auth_token
            end
            response.user = user
            response.privileges = []
            response.is_successful = true
        else
            response.is_successful = false
        end

        render json: response, status: status
    end

    def destroy
        params = user_params
        email = params[:email]
        password = params[:password]
        response = FlaggedResponse.new
        status = :ok

        user = UserService::authenticate email, password
        if user
            user.active = false
            user.save
            response.is_successful = true
            message = "User with email address '#{email}' has been deactivated"
            log message
            response.add_message message
            if UserService.current_user && UserService.current_user.email === user.email
                UserService.current_user.auth_token = nil
                log "Destroyed user, so token data has been cleared"
            end
        else
            response.is_successful = false
            response.add_message "Unable to authenticate user"
            log "Deactivation Authentication for user '#{email}' has failed"
        end

        render json: response, status: status
    end

    def recover_password
        email = params[:email]
        unless email
            response = ApiResponse.new
            response.add_message "A valid email must be provided."
            render json: response, status: :bad_request
            return
        end
        response = RecoverPasswordResponse.new

        user = User.find_by email: email
        unless user
            response = ApiResponse.new
            response.add_message "Unable to find user with email address '#{email}'"
            render json: response, status: :bad_request
            return
        end

        # Check for existing reset key
        reset_key = PasswordResetKey.find_by user_id: user.id, active: true
        if reset_key
            log "Retrieved existing password reset key for #{user.inspect}:#{$/}\t#{reset_key.inspect}"
        else
            reset_key = PasswordResetKey.create reset_key: SecureRandom.uuid, user_id: user.id, active: true
            log "Generated new password reset key for #{user.inspect}:#{$/}\t#{reset_key.inspect}"
        end
        reset_key.save

        DefaultMailer.with(user_id: user.id, key: reset_key.reset_key).recover_password.deliver
        response.is_successful = true

        render json: response
    end

    def reset_password
        params = user_params

        if params[:key]
            render reset_password_with_key params
        else
            render reset_password_without_key params
        end
    end

    private

    def user_params
        params.permit :user, :email, :password, :id, :first_name, :last_name, :role, :role_id, :privileges, :key, :old_password, :new_password, :with_auth_token
    end

    def reset_password_with_key(params)
        response = ResetPasswordResponse.new
        status = :ok
        key = params[:key]

        log "Resetting password for key: #{key.inspect}"
        password_reset_key = PasswordResetKey.find_by reset_key: key, active: true
        if password_reset_key
            password_reset_key.active = false

            user = User.find_by_id password_reset_key.user_id
            old_password_digest = user.password_digest
            user.password = params[:password]
            user.save

            # Deactivate all reset keys for this user
            PasswordResetKey.where(user_id: user.id, active: true).each do |reset_key|
                reset_key.active = false
                reset_key.save
            end

            log "New Password: #{params[:password]}"
            log "New Password Digest: #{user.password_digest}", false
            log "Old Password Digest: #{old_password_digest}", false
            log "User: #{user.inspect}"

            response.is_successful = true
        else
            response.user = nil
            response.is_successful = false
            response.add_message "Invalid key provided"
            log "Password reset attempted with invalid key '#{key}'"
        end

        { json: response, status: status }
    end

    def reset_password_without_key(params)
        response = ResetPasswordResponse.new
        status = :ok

        email = params[:email]
        old_password = params[:old_password]
        new_password = params[:new_password]

        response.add_message "Must provide email address" unless email
        response.add_message "Must provide old password" unless old_password
        response.add_message "Must provide new password" unless new_password

        if response.messages.length === 0
            user = User.find_by email: email
            if user
                if UserService::authenticate email, old_password
                    user.password = new_password
                    user.save

                    response.user = UserData.new user
                else
                    response.add_message "Failed to authenticate old password"
                end

            else
                response.add_message "User with email address '#{email}' does not exist"
                status = :bad_request
            end
        else
            status = :bad_request
        end

        { json: response, status: status }
    end

end