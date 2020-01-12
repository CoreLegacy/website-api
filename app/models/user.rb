require_relative "./application_record"

class User < ApplicationRecord
    has_secure_password
    has_one :role
    has_many :user_privileges, :class_name => 'UserPrivilege'
    has_many :staffs, :class_name => 'Staff'

    validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
    validates_presence_of :email, :password_digest, :first_name, :role_id
    validates_uniqueness_of :email

    before_save :format_fields

    def format_fields
        self.email = self.email.downcase if self.email
    end
end
