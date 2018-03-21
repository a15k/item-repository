class Member < ApplicationRecord

  has_many :user, inverse_of: :member

end
