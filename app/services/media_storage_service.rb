module MediaStorageService

    def store(upload_data, medium)
        bucket_name = Rails.application.credentials.aws[:bucket]

        s3 = Aws::S3::Resource.new(
            region: Rails.application.credentials.aws[:region],
            access_key_id: Rails.application.credentials.aws[:access_key_id],
            secret_access_key: Rails.application.credentials.aws[:secret_access_key]
        )
        bucket = s3.bucket bucket_name

        # Create the object to upload
        obj = bucket.object medium.checksum

        # Upload it
        obj.upload_file upload_data.media_data, { acl: 'public-read' }
    end

end