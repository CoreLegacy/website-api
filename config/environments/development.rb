Rails.application.configure do
    # Settings specified here will take precedence over those in config/application.rb.

    # In the development environment your application's code is reloaded on
    # every request. This slows down response time but is perfect for development
    # since you don't have to restart the web server when you make code changes.
    config.cache_classes = false

    # Do not eager load code on boot.
    config.eager_load = false

    # Show full error reports.
    config.consider_all_requests_local = true

    # Enable/disable caching. By default caching is disabled.
    # Run rails dev:cache to toggle caching.
    if Rails.root.join('tmp', 'caching-dev.txt').exist?
        config.cache_store = :memory_store
        config.public_file_server.headers = {
            'Cache-Control' => "public, max-age=#{2.days.to_i}"
        }
    else
        config.action_controller.perform_caching = false

        config.cache_store = :null_store
    end

    # Store uploaded files on the local file system (see config/storage.yml for options).
    config.active_storage.service = :local

    config.action_mailer.perform_caching = false

    # Print deprecation notices to the Rails logger.
    config.active_support.deprecation = :log

    # Raise an error on page load if there are pending migrations.
    config.active_record.migration_error = :page_load

    # Highlight code that triggered database queries in logs.
    config.active_record.verbose_query_logs = true

    ###################
    # Custom Settings #
    ###################

    config.FRONTEND_URL = "http://localhost:63342/UI/#!/"

    config.DEFAULT_PORT = 8080

    config.serve_static_assets = true
    config.require_master_key = true

    config.IDLE_TIMEOUT = 2.hours.minutes
    config.JWT_EXPIRY = 100

    config.action_mailer.raise_delivery_errors = true
    config.action_mailer.perform_deliveries = true
    config.action_mailer.delivery_method = :smtp
    config.action_mailer.smtp_settings = {
        :address => "smtp.gmail.com",
        :port => 587,
        :domain => "gmail.com",
        :user_name => Rails.application.credentials.dig(:development, :email, :address),
        :password => Rails.application.credentials.dig(:development, :email, :password),
        :authentication => "plain",
        :enable_starttls_auto => true
    }

    config.S3_BUCKET_NAME = "dev.corelegacy.org.media"
    config.AWS_REGION = "us-east-2"

    # The root uri of the storage location for media files
    config.MEDIA_ROOT_URI = "https://s3.us-east-2.amazonaws.com/#{config.S3_BUCKET_NAME}/"

    config.require_master_key = true
    config.active_storage.service = :amazon

    # Raises error for missing translations.
    # config.action_view.raise_on_missing_translations = true

    # Use an evented file watcher to asynchronously detect changes in source code,
    # routes, locales, etc. This feature depends on the listen gem.
    # config.file_watcher = ActiveSupport::EventedFileUpdateChecker
end
