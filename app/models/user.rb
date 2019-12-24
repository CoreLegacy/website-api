class User < ActiveRecord::Base
    has_one :role
    has_many :user_privileges, :class_name => 'UserPrivilege'
    has_many :staffs, :class_name => 'Staff'
end
