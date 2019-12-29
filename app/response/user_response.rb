require_relative "./flagged_response"

class UserResponse < FlaggedResponse
    attr_accessor :user
    attr_accessor :privileges

    def initialize
        super
    end
end