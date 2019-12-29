require_relative "./flagged_response"

class ResetPasswordResponse < FlaggedResponse
    attr_accessor :user

    def initialize
        super
    end
end