module MediaStorageService

    def store(upload_data, medium)
        bucket_name = Rails.application.config.S3_BUCKET_NAME

        s3 = Aws::S3::Resource.new(
            region: Rails.application.config.AWS_REGION,
            access_key_id: Rails.application.credentials.dig(:aws, :access_key_id),
            secret_access_key: Rails.application.credentials.dig(:aws, :secret_access_key)
        )
        bucket = s3.bucket bucket_name

        # Create the object to upload
        obj = bucket.object medium.checksum

        # Upload it
        obj.upload_file upload_data.media_data, { acl: 'public-read' }
    end

end