require_relative "./application_record"

class Role < ApplicationRecord
    ADMIN = "admin"
    STAFF = "staff"
    MEMBER = "member"

    validates_uniqueness_of :name
    validates_presence_of :name
end
