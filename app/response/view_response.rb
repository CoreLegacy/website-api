require_relative "./api_response"

class ViewResponse < ApiResponse
    attr_accessor :view
    attr_accessor :media
    attr_accessor :texts

    def initialize
        super
    end
end