require_relative "./application_controller"

class LoginController < ApplicationController

    def create
        params = user_params
        response = UserResponse.new
        email = params[:email]
        password = params[:password]

        response.user = UserService::authenticate email, password

        
        render json: response
    end

    def destroy
        session.clear
    end

    private

    def user_params
        params.permit :user, :email, :password
    end

end