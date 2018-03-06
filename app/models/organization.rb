class Organization < ApplicationRecord

  has_many :user, inverse_of: :organization

end
