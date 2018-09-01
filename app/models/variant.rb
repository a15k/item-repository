class Variant < ApplicationRecord

  belongs_to :assessment
  belongs_to :format
  has_many :solutions, inverse_of: :variant, dependent: :destroy
  has_many :assets, as: :owner, dependent: :destroy

  validates :content, presence: true
  validates :assessment, presence: true
  validates :format, presence: true

  # If provided, should be unique within the assessment
  validates :member_variant_id, uniqueness: { scope: :assessment }, allow_blank: true

end
