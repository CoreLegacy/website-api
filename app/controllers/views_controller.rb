require_relative './application_controller'
require_relative '../services/view_service'

include ViewService

class ViewsController < ApplicationController

    skip_before_action :authorize

    def index
        params = view_params

        response = ViewResponse.new
        response.view = ViewService.get_view_data params[:name]

        render json: response
    end

    def update

    end

    private

    def view_params
        params.permit :name, :id
    end

end