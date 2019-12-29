require_relative "./application_controller"
require "securerandom"

class RegistrationController < ApplicationController

    def create
        params = user_params
        user = UserService::create params

        DefaultMailer.with(user_id: user.id).welcome_email.deliver

        response = UserResponse.new
        response.user = user
        response.privileges = []

        render json: response
    end

    def destroy
        user = UserService.current_user
        if user
            user.active = false
            user.save
        end
        session.clear
    end

    def reset_password
        email = params[:email]
        unless email
            render json: { messages: ["A valid email must be provided."] }, status: :bad_request
            return
        end

        user = User.find_by email: email
        unless user
            render json: { messages: ["Unable to find user with email address '#{email}'"] }, status: :bad_request
            return
        end

        # Check for existing reset key
        reset_key = PasswordResetKey.find_by user_id: user.id, active: true
        if reset_key
            log "#{$/}Retrieved existing password reset key for #{user.inspect}:#{$/}\t#{reset_key.inspect}{$/}"
        else
            reset_key = PasswordResetKey.create reset_key: SecureRandom.uuid, user_id: user.id, active: true
            log "#{$/}Generated new password reset key for #{user.inspect}:#{$/}\t#{reset_key.inspect}{$/}"
        end

        log "Created Password Reset Key: #{$/}\t#{reset_key.inspect}"
        reset_key.save

        DefaultMailer.with(user_id: user.id, key: reset_key.reset_key).reset_password.deliver
        render json: { key: reset_key.reset_key }
    end

    def update
        params = user_params
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

            log "{$/}New Password: #{params[:password]}"
            log "New Password Digest: #{user.password_digest}"
            log "Old Password Digest: #{old_password_digest}"
            log "User: #{user.inspect}{$/}"

            render json: user
        else
            render json: { messages: "No such key is active. Please create a new reset key." }, status: :bad_request
        end
    end

    private

    def user_params
        params.permit :user, :email, :password, :id, :first_name, :last_name, :role, :role_id, :privileges, :key
    end

end