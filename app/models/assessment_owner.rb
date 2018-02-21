class AssessmentOwner < ApplicationRecord

  belongs_to :organization
  belongs_to :license

  has_many :assessments,
            -> { order(created_at: :desc) },
            inverse_of: :owner

  validates :organization, :license, presence: true
end
