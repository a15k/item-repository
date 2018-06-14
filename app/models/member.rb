class Member < ApplicationRecord

  has_many :users, inverse_of: :member, dependent: :destroy
  has_many :access_tokens

  after_create { |member| member.access_tokens.create! }

end
