require_relative "./application_record"
require "securerandom"

class Medium < ApplicationRecord
    validates_presence_of :checksum, :uri

    before_save :remove_media_root_uri

    after_find do |medium|
        self.uri = Rails.application.config.MEDIA_ROOT_URI + self.uri
    end

    def remove_media_root_uri
        self.uri.remove Rails.application.config.MEDIA_ROOT_URI
    end
end
