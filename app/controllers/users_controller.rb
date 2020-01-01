require_relative './application_controller'
require_relative '../services/user_service'
require_relative '../../app/mailers/default_mailer'

class UsersController < ApplicationController
    include UserService

    skip_before_action :authorize, only: :exists

    def index
        params = user_params
        response = UserResponse.new
        status = :ok

        email = params[:email]

        if email
            user = UserService::get email
            if user
                response.user = user
                response.is_successful = true
            else
                response.is_successful = false
                response.add_message "User with email address '#{email}' does not exist."
            end
        else
            all_users = UserService::get_all
            response = { all_users: all_users }
        end

        render json: response, status: status
    end

    def exists
        params = user_params
        email = params[:email]
        response = FlaggedResponse.new
        response.is_successful = false
        if email
            response.is_successful = User.exists? email: email
        end

        render json: response
    end

    def update
        params = user_params
        email = params[:email]

        response = UserResponse.new
        status = :ok

        if email
            user = User.find_by email: email
            if user
                UserService::update user, params
            else
                status = :bad_request
                response.add_message "User with email address ''#{email}'' does not exist."
            end
        else
            status = :bad_request
            response.add_message "Must provide user's email address"
        end

        render json: response, status: status
    end

    private

    def user_params
        params.permit :user, :email, :password, :id, :first_name, :last_name, :role, :role_id, :privileges
    end

end