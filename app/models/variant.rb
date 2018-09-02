class Variant < ApplicationRecord

  belongs_to :assessment
  belongs_to :format
  has_many :solutions, inverse_of: :variant, dependent: :destroy
  has_many :assets, as: :owner, dependent: :destroy

  validates :content, presence: true
  validates :assessment, presence: true
  validates :source_identifier, uniqueness: { scope: :assessment }, allow_blank: true

  def other_variants
    assessment ? assessment.variants.without(self) : []
  end

end
