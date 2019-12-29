require_relative "./application_controller"
require_relative "../../app/services/media_service"

include MediaService

class MediaController < ApplicationController

    def index
        params = media_params

        if params[:id]
            medium = Medium.find_by_id params[:id]
            response = MediumResponse.new
            response.medium = MediaData.new medium
        elsif params[:mime_primary_type]
            media = Medium.joins(:media_type).where(media_types: { mime_primary_type: params[:mime_primary_type] })
            response = MediaResponse.new
            media.each { |medium| response.media.push MediaData.new medium }
        else
            response = MediaResponse.new
            Medium.all.each { |medium| response.media.push MediaData.new medium }
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
        params = media_params
        medium_id = params[:id]
        status = :ok

        response = MediaDeleteResponse.new
        response.views_affected = []
        medium = Medium.find_by_id medium_id
        if medium
            ViewMedium.where(medium_id: medium.id).each do |view_medium|
                response.views_affected.push View.find_by_id(view_medium.id).name
                view_medium.destroy
            end
            medium.destroy
        else
            status = :bad_request
            response = ApiResponse.new
            response.add_message "Media does not exist."
        end

        render json: response, status: status
    end

    private

    def media_params
        params.permit :user, :media_data, :title, :mime_primary_type, :mime_sub_type, :id
    end

end