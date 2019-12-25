require_relative "./application_record"

class Medium < ApplicationRecord
    validates_presence_of :checksum, :uri
end
