require_relative "./application_record"

class Image < ApplicationRecord
    validates_uniqueness_of :checksum
    validates_presence_of :checksum, :uri
end
