require_relative "../services/log_service"

class ApplicationMailer < ActionMailer::Base
    include LogService
    
    default from: Rails.application.credentials[Rails.application.config.ENVIRONMENT][:email][:address]
    layout 'mailer'
end
