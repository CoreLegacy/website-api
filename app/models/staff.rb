require_relative "./application_record"

class Staff < ApplicationRecord
    validates_presence_of :user_id, :title
    belongs_to :user, :class_name => 'User', :foreign_key => :user_id
end
