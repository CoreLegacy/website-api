require_relative './application_controller'
require_relative '../services/view_service'

class ViewsController < ApplicationController
    include ViewService

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