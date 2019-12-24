class ApplicationRecord < ActiveRecord::Base
    self.abstract_class = true

    before_create :set_created_timestamp
    before_save :set_last_updated_timestamp

    def set_created_timestamp
        self.created = DateTime.now
    end

    def set_last_updated_timestamp
        self.last_updated = DateTime.now
    end
end
