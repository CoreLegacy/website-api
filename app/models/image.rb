require_relative "./application_record"

class Image < ApplicationRecord
    validates_uniqueness_of :hash
    validates_presence_of :hash, :uri
end
