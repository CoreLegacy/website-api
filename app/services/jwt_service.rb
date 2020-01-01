require 'jwt'

include JWT
module JWTService
    include LogService

    def self.encode(payload)
        JWT.encode(payload, Rails.application.secrets.secret_key_base)
    end

    def self.decode(token)
        begin
            hash = HashWithIndifferentAccess.new(JWT.decode(token, Rails.application.secrets.secret_key_base)[0])
            return hash
        rescue => exception
            log_error exception
            nil
        end
    end

end