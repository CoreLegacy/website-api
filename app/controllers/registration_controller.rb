require_relative "./application_controller"
require_relative "../services/user_service"
require "securerandom"

include UserService

class RegistrationController < ApplicationController

    def create
        params = user_params
        response = ApiResponse.new
        status = :bad_request

        response.add_message "Must provide email address" unless params[:email]
        response.add_message "Must provide passsword" unless params[:password]
        response.add_message "User with email address '#{params[:email]}' already exists" if User.find_by(email: params[:email])

        unless response.messages.length > 0
            user = UserService::create params

            DefaultMailer.with(user_id: user.id).welcome_email.deliver

            response = UserResponse.new
            response.user = user
            response.privileges = []
            status = :ok
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
                session.clear
                log "Destroyed current user, so session data has been cleared"
            end
        else
            response.is_successful = false
            response.add_message "Unable to authenticate user"
            log "Deactivation Authentication for user '#{email}' has failed"
            status = :bad_request
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
        response.key = reset_key.reset_key

        render json: response
    end

    def reset_password
        params = user_params
        key = params[:key]
        response = ResetPasswordResponse.new

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

            response.user = UserData.new user
            response.is_successful = true

            render json: UserData.new(user)
        else
            response.user = nil
            response.is_successful = false
            response.add_message "No such key is active. Please create a new reset key."
            render json: response, status: :bad_request
        end
    end

    private

    def user_params
        params.permit :user, :email, :password, :id, :first_name, :last_name, :role, :role_id, :privileges, :key
    end

end