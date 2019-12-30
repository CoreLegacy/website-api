require_relative "./application_controller"

class LoginController < ApplicationController

    def create
        params = user_params
        response = UserResponse.new
        status = :ok

        email = params[:email]
        password = params[:password]

        if !email || !password
            status = :bad_request
            response = FlaggedResponse.new
            response.is_successful = false
            response.add_message "Must provide a valid email and password"
        elsif UserService::authenticate email, password
            user = User.find_by(email: email)
            session[:user_id] = user.id

            response.user = UserData.new(user)
            response.is_successful = true
        else
            status = :bad_request
            response = FlaggedResponse.new
            response.is_successful = false
            response.add_message "Unable to authenticate user."
        end

        render json: response, status: status
    end

    def destroy
        session.clear
        response = FlaggedResponse.new
        response.is_successful = true

        render json: response
    end

    private

    def user_params
        params.permit :user, :email, :password
    end

end