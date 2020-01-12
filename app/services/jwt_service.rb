require 'jwt'

include JWT
module JwtService
    include LogService

    def self.encode(payload)
        payload = "" unless payload

        log "Encoding JWT Payload: #{payload}"
        secret = Rails.application.credentials.secret_key_base
        JWT.encode(payload, secret)
    end

    def self.decode(token)
        return nil unless token

        begin
            hash = HashWithIndifferentAccess.new(JWT.decode(token, Rails.application.credentials.secret_key_base)[0])
            return hash
        rescue => exception
            log_error exception
            nil
        end
    end

end