require_relative "./application_record"

class Page < ApplicationRecord
    has_many :page_images, :class_name => 'PageImage'
    has_many :page_texts, :class_name => 'PageText'
end
