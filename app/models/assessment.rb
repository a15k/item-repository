class Assessment < ApplicationRecord

  belongs_to :organization
  belongs_to :license

  has_many :versions,
            -> { order(created_at: :desc) },
            inverse_of: :assessment

  validates :organization, :license, presence: true
end
