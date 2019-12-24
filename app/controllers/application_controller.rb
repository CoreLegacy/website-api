class ApplicationController < ActionController::API

    before_action :set_user

    def set_user
        @current_user = session[:current_user]
    end

end
