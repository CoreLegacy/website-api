require_relative "../services/user_service"

class ApplicationController < ActionController::API
    include UserService

    before_action :set_user

    def set_user
        @current_user            = session[:current_user]
        UserService.current_user = @current_user
    end

end
