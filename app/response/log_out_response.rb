class LogOutResponse < FlaggedResponse
    attr_accessor :logged_out
    attr_accessor :session_expired
end