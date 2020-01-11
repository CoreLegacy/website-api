require_relative "../services/user_service"

class ApplicationRecord < ActiveRecord::Base
    include UserService
    self.abstract_class = true

    before_create :set_created_timestamp
    before_save :set_last_updated

    def set_created_timestamp
        self.created = Time.now
    end

    def save
        old_logger = ActiveRecord::Base.logger
        ActiveRecord::Base.logger = nil
        super
        ActiveRecord::Base.logger = old_logger
    end

    def set_last_updated
        self.last_updated = Time.now
        user = UserService.current_user
        if user
            self.last_updated_by = user.id
        else
            self.last_updated_by = nil
        end
    end

    def to_hash
        hash = {}
        self.attributes.each do |name, value|
            begin
                if value
                    hash[name.to_s.delete("@")] = value
                end
            end
        end
        hash
    end

    def get_attributes
        attributes = []
        self.attributes.each do |name, value|
            begin
                if value
                    attributes.push name
                end
            end
        end
        attributes
    end
end
