require_relative "./api_response"

class FlaggedResponse < ApiResponse
    attr_accessor :is_successful

    def initialize
        super
    end
end