require_relative "./application_record"

class Privilege < ApplicationRecord
    MEDIA = "media"
    TEXT = "text"
    EVENTS = "events"
    BLOG = "blog"

    validates_uniqueness_of :name
    validates_presence_of :name

    has_many :user_privileges
end
