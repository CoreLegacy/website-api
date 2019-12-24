require_relative "./application_record"

class Privilege < ApplicationRecord
    validates_presence_of :name
end
