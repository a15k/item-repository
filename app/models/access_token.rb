class AccessToken < ApplicationRecord

  belongs_to :member

  scope :valid, -> { where(is_revoked: false) }

  ALGORITHM = 'HS256'

  def expiration
    30.days.from_now.to_i
  end

  def as_jwt
    JWT.encode({ id: id, exp: expiration }, AccessToken.secret, ALGORITHM)
  end

  def self.member_for(jwt:)
    type, token = jwt.split(' ')
    token = type if token.blank?
    token_id = nil
    begin
      token = JWT.decode(token, secret, true, algorithm: ALGORITHM).first
      token_id = token['id']
    rescue => e
      Rails.logger.warn "Failed to decode JWT token: #{e}"
    end
    return nil unless token_id
    Member.joins(:access_tokens).where(access_tokens: { id: token_id, is_revoked: false }).first
  end

  private

  def self.secret
    Rails.application.secrets.secret_key_base
  end

end
