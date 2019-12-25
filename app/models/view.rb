require_relative "./application_record"

class View < ApplicationRecord
    validates_uniqueness_of :name
    validates_presence_of :name

    has_many :view_medium, :class_name => 'ViewMedium'
    has_many :view_texts, :class_name => 'ViewText'
end
