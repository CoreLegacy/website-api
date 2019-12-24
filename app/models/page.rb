require_relative "./application_record"

class Page < ApplicationRecord
    validates_uniqueness_of :name
    validates_presence_of :name

    has_many :page_images, :class_name => 'PageImage'
    has_many :page_texts, :class_name => 'PageText'
end
