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
