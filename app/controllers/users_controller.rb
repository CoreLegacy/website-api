require_relative './application_controller'
require_relative '../services/user_service'
require_relative '../../app/mailers/default_mailer'

class UsersController < ApplicationController
    include UserService

    def index
        params = user_params
        response = UserResponse.new
        status = :ok

        user_id = params[:id]

        if user_id
            user = UserService::get user_id
            if user
                response.user = user
            else
                status = :bad_request
                response.add_message "User does not exist."
            end
        else
            response = UserService::get_all
        end

        render json: response, status: status
    end

    def update
        params = user_params
        user_id = params[:id]

        response = UserResponse.new
        status = :ok

        if user_id
            user = User.find_by_id user_id
            if user
                UserService::update user, params
            else
                status = :bad_request
                response.message = "User does not exist."
            end
        else
            status = :bad_request
            response.messages = "Must provide user's ID"
        end

        render json: response, status: status
    end

    private

    def user_params
        params.permit :user, :email, :password, :id, :first_name, :last_name, :role, :role_id, :privileges
    end

end