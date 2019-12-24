require_relative "./application_record"

class Event < ApplicationRecord
    validates_presence_of :title
    validates_presence_of :start

end
