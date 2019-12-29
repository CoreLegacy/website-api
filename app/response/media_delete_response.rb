require_relative "./api_response"

class MediaDeleteResponse < ApiResponse
    attr_accessor :views_affected

    def initialize
        super
    end
end