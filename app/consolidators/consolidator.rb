class Consolidator
    attr_accessor :created
    attr_accessor :last_updated
    attr_accessor :last_updated_by

    def initialize(model = nil)
        if model
            self.created = model.created
            self.last_updated = model.last_updated
            self.last_updated_by = model.last_updated_by
        end
    end
end