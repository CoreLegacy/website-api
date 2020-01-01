require_relative './flagged_response'

class LoginResponse < FlaggedResponse
    attr_accessor :auth_token
    attr_accessor :user
end