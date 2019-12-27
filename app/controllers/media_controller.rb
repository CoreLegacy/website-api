require_relative "./application_controller"
require_relative "../../app/services/media_service"

include MediaService

class MediaController < ApplicationController

    def index
        params = media_params
        if params[:id]
            response = Medium.find params[:id]
        else
            response = Medium.all
        end

        render json: response
    end

    def create
        params = media_params

        media_file = params[:media_data]
        content_type = media_file.content_type
        if content_type
            content_type = content_type.split "/"
            # Remove optional parameters from subtype (starts with semicolon)
            content_type[1] = content_type[1][/^[^;]*/]
            puts "Content SubType after sub: #{content_type[1]}"
        else
            content_type = %w{image jpg}
        end

        upload_data = MediaUpload.new
        upload_data.mime_primary_type = content_type[0]
        upload_data.mime_sub_type = content_type[1]
        upload_data.media_data = params[:media_data]
        upload_data.title = params[:title]

        response = MediaService::upsert_media upload_data

        render json: response
    end

    def destroy
        session.clear
    end

    private

    def media_params
        params.permit :user, :media_data, :title, :type, :sub_type, :id
    end

end