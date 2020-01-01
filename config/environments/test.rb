# The test environment is used exclusively to run your application's
# test suite. You never need to work with it otherwise. Remember that
# your test database is "scratch space" for the test suite and is wiped
# and recreated between test runs. Don't rely on the data there!

Rails.application.configure do
    # Settings specified here will take precedence over those in config/application.rb.

    config.cache_classes = true

    # Do not eager load code on boot. This avoids loading your whole application
    # just for the purpose of running a single test. If you are using a tool that
    # preloads Rails for running tests, you may have to set it to true.
    config.eager_load = false

    # Configure public file server for tests with Cache-Control for performance.
    config.public_file_server.enabled = true
    config.public_file_server.headers = {
        'Cache-Control' => "public, max-age=#{1.hour.to_i}"
    }

    # Show full error reports and disable caching.
    config.consider_all_requests_local = true
    config.action_controller.perform_caching = false
    config.cache_store = :null_store

    # Raise exceptions instead of rendering exception templates.
    config.action_dispatch.show_exceptions = false

    # Disable request forgery protection in test environment.
    config.action_controller.allow_forgery_protection = false

    # Store uploaded files on the local file system in a temporary directory.
    config.active_storage.service = :test

    config.action_mailer.perform_caching = false

    # Print deprecation notices to the stderr.
    config.active_support.deprecation = :stderr

    # Raises error for missing translations.
    # config.action_view.raise_on_missing_translations = true

    ###################
    # Custom Settings #
    ###################

    config.force_ssl = true
    config.require_master_key = true
    config.ENVIRONMENT = :test
    config.IDLE_TIMEOUT = 10.minutes
    config.JWT_EXPIRY = 8

    config.action_mailer.default_url_options = { :host => 'https://test-corelegacy-org-api.herokuapp.com' }
    config.action_mailer.raise_delivery_errors = true
    config.action_mailer.perform_deliveries = true
    config.action_mailer.delivery_method = :smtp
    config.action_mailer.smtp_settings = {
        :address => "smtp.gmail.com",
        :port => 587,
        :domain => "gmail.com",
        :user_name => Rails.application.credentials.dig(:test, :email, :address),
        :password => Rails.application.credentials.dig(:test, :email, :password),
        :authentication => "plain",
        :enable_starttls_auto => true
    }

    config.S3_BUCKET_NAME = "test.corelegacy.org.media"
    config.AWS_REGION = "us-east-2"

    # The root uri of the storage location for media files
    config.MEDIA_ROOT_URI = "https://s3.us-east-2.amazonaws.com/#{config.S3_BUCKET_NAME}/"

    config.require_master_key = true
    config.active_storage.service = :amazon
end
