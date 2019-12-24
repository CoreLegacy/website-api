require_relative "./application_record"

class User < ApplicationRecord
    validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
    validates_presence_of :email, :password, :first_name, :role_id
    validates_uniqueness_of :email

    has_one :role
    has_many :user_privileges, :class_name => 'UserPrivilege'
    has_many :staffs, :class_name => 'Staff'
end
