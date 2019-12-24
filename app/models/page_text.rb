require_relative "./application_record"

class PageText < ApplicationRecord
    validates_presence_of :page_id, :text_id, :element_id

    belongs_to :page, :class_name => 'Page', :foreign_key => :page_id
    belongs_to :text, :class_name => 'Text', :foreign_key => :text_id
end
