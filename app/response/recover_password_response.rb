require_relative "./flagged_response"

class RecoverPasswordResponse < FlaggedResponse
    attr_accessor :key

    def initialize
        super
    end
end