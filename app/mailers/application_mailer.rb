require_relative "../services/log_service"

class ApplicationMailer < ActionMailer::Base
    include LogService

    default from: Rails.application.credentials.dig(Rails.env, :email, :address)
    layout 'mailer'
end
