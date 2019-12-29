require "aws-sdk-s3"
require_relative "../../db/db_utility"
require_relative "./media_storage_service"
require_relative "./service_base"

include MediaStorageService
include DbUtility

module MediaService
    include ServiceBase

    def upsert_media(upload_data)
        media_type = MediaType.new
        media_type.mime_primary_type = upload_data.mime_primary_type
        media_type.mime_sub_type = upload_data.mime_sub_type
        media_type = DbUtility::upsert media_type

        raw_data = upload_data.media_data.read
        # Need to reset the reader back to start
        upload_data.media_data.open { |f| f.seek 0, IO::SEEK_SET }
        checksum = MediaService::calculate_checksum raw_data

        medium = Medium.find_by checksum: checksum
        unless medium
            medium = Medium.new
        end

        medium.checksum = MediaService::calculate_checksum raw_data
        medium.file_extension = upload_data.mime_sub_type
        medium.uri = "#{medium.checksum}"
        medium.media_type_id = media_type.id
        medium.title = upload_data.title
        medium.save

        MediaStorageService::store upload_data, medium

        medium
    end


    def delete(medium)

    end

    def calculate_checksum(data)
        Digest::MD5.hexdigest(data)
    end

end