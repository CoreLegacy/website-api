require_relative "./application_record"

class ViewMedium < ApplicationRecord
    validates_presence_of :view_id, :medium_id, :identifier

    belongs_to :views, :class_name => 'View', :foreign_key => :view_id
    belongs_to :media, :class_name => 'Medium', :foreign_key => :medium_id
end
