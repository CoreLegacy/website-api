require_relative "./api_response"

class UserResponse < ApiResponse
    attr_accessor :user
    attr_accessor :privileges

    def initialize
        super
    end
end