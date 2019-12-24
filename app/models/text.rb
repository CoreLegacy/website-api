require_relative "./application_record"

class Text < ApplicationRecord
    validates_presence_of :content
end
