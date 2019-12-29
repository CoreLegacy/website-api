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
        user_id = params[:id]
        unless user_id
            user_id = current_user.id
        end

        reset_key = PasswordResetKey.create reset_key: SecureRandom.uuid, user_id: user_id, active: true
        log "Created Password Reset Key: #{$/}\t#{reset_key.inspect}"
        reset_key.save

        DefaultMailer.with(user_id: user_id, key: reset_key.reset_key).reset_password.deliver
        render json: { key: reset_key.reset_key }
    end

    def update
        params = user_params
        key = params[:key]

        log key.inspect
        password_reset_key = PasswordResetKey.find_by reset_key: key, active: true
        password_reset_key.active = false

        user = User.find_by_id password_reset_key.user_id
        user.password = params[:password]

        password_reset_key.save
        user.save
    end

    private

    def user_params
        params.permit :user, :email, :password, :id, :first_name, :last_name, :role, :role_id, :privileges, :key
    end

end