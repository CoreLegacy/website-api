require 'jwt'

include JWT
module JwtService
    include LogService

    def self.encode(payload)
        log "Encoding JWT Payload: #{payload}"
        secret = Rails.application.secrets.secret_key_base
        log "Secret Key for JWT Hash: #{secret}"
        JWT.encode(payload, secret)
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