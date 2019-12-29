require_relative "./application_controller"

class LoginController < ApplicationController

    def create
        params = user_params
        response = UserResponse.new
        email = params[:email]
        password = params[:password]
        status = :ok

        if !email || !password
            status = :bad_request
            response = ApiResponse.new
            response.add_message "Must provide a valid email and password"
        else
            response.user = UserService::authenticate email, password
            if response.user
                session[:user_id] = response.user
            end
        end

        render json: response, status: status
    end

    def destroy
        session.clear
    end

    private

    def user_params
        params.permit :user, :email, :password
    end

end