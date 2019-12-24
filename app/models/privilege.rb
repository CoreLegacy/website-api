require_relative "./application_record"

class Privilege < ApplicationRecord
    validates_uniqueness_of :name
    validates_presence_of :name
end
