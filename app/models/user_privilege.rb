require_relative "./application_record"

class UserPrivilege < ApplicationRecord
    validates_presence_of :user_id, :privilege_id

    belongs_to :user, :class_name => 'User', :foreign_key => :user_id
    belongs_to :privilege, :class_name => 'Privilege', :foreign_key => :privilege_id
end
