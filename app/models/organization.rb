class Organization < ApplicationRecord

  has_many :user_profiles, inverse_of: :organization

end
