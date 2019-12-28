require_relative './application_controller'
require_relative '../services/user_service'
require_relative '../../app/mailers/default_mailer'

class UsersController < ApplicationController
    include UserService

    def index
        params = user_params
        response = UserResponse.new

        user_id = params[:id].to_i

        if user_id
            response.user = UserService::get user_id
        else
            response.add_message "Unable to locate user"
        end

        render json: response
    end

    def create
        params = user_params
        user = UserService::create params

        DefaultMailer.with(user_id: user.id).welcome_email.deliver

        response = UserResponse.new
        response.user = user
        response.privileges = []

        render json: response
    end

    private

    def user_params
        params.permit :user, :email, :password, :id, :first_name, :last_name, :role, :role_id
    end

end