require_relative "./application_record"

class Role < ApplicationRecord
    validates_uniqueness_of :name
    validates_presence_of :name
end
