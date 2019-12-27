require_relative "./application_record"

class MediaType < ApplicationRecord
    validates_presence_of :mime_primary_type, :mime_sub_type
end