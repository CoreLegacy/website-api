require_relative "./api_response"

class RecoverPasswordResponse < ApiResponse
    attr_accessor :key

    def initialize
        super
    end
end