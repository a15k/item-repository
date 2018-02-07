class Tag < ApplicationRecord

  belongs_to :organization

  validates :name, :organization, presence: true

end
