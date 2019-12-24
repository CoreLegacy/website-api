class UserPrivilege < ActiveRecord::Base
    belongs_to :user, :class_name => 'User', :foreign_key => :user_id
    belongs_to :privilege, :class_name => 'Privilege', :foreign_key => :privilege_id
end
