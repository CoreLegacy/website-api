require_relative "./flagged_response"

class UserResponse < FlaggedResponse
    attr_accessor :user
    attr_accessor :privileges
    attr_accessor :auth_token

    def initialize
        super
    end
end