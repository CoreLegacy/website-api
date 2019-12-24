require_relative "./application_record"

class PageImage < ApplicationRecord
    validates_presence_of :page_id, :image_id, :element_id

    belongs_to :page, :class_name => 'Page', :foreign_key => :page_id
    belongs_to :image, :class_name => 'Image', :foreign_key => :image_id
end
