require_relative "./application_record"

class ViewText < ApplicationRecord
    validates_presence_of :view_id, :text_id, :identifier

    belongs_to :page, :class_name => 'View', :foreign_key => :view_id
    belongs_to :text, :class_name => 'Text', :foreign_key => :text_id
end
