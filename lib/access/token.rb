require 'jwt'

module Access
  module Token
    extend self

    def expiration
      30.days.from_now.to_i
    end

    def secret
      Rails.application.secrets.secret_key_base
    end

    def for_user(user)
        JWT.encode({id: user.id, exp: expiration}, secret, 'HS256')
    end

    def decode(authorization:)
      type, token = authorization.split(' ')
      token = type if token.blank?
      begin
        JWT.decode(token, secret, true, algorithm: 'HS256').first
      rescue => e
        Rails.logger.warn "Failed to decode JWT token: #{e}"
        nil
      end
    end
  end
end
