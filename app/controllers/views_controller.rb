require_relative './application_controller'
require_relative '../services/view_service'

class ViewsController < ApplicationController
    include ViewService

    def index
        params = view_params
        view = View.find_by name: params[:name]
        response = ViewResponse.new
        response.view = view
        response.media = ViewService.get_media_data view
        response.texts = ViewService.get_texts_data view

        render json: response
    end

    private

    def view_params
        params.permit :name, :id
    end

end