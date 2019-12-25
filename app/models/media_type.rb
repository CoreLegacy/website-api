require_relative "./application_record"

class MediaType < ApplicationRecord
    validates_presence_of :description
    validates_uniqueness_of :description

    IMAGE_DESC = "image"
    VIDEO_DESC = "video"
    AUDIO_DESC = "audio"
end