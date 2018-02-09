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

    def for_profile(profile)
        JWT.encode({id: profile.id, exp: expiration}, secret, 'HS256')
    end

    def decode(token)
      begin
        JWT.decode(token, secret, true, algorithm: 'HS256').first
      rescue
        nil
      end
    end
  end
end
