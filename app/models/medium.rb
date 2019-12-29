require_relative "./application_record"
require "securerandom"

class Medium < ApplicationRecord
    validates_presence_of :checksum, :uri
    belongs_to :media_type

    before_save :remove_media_root_uri
    after_find :set_relations

    attr_accessor :media_type

    def set_relations
        log "Setting media type on Medium with id #{self.media_type_id}"
        self.media_type = MediaType.find_by_id self.media_type_id
        log "Media Type is #{self.media_type.inspect}"
    end

    after_find do |medium|
        self.uri = Rails.application.config.MEDIA_ROOT_URI + self.uri
    end

    def remove_media_root_uri
        self.uri.remove Rails.application.config.MEDIA_ROOT_URI
    end
end
