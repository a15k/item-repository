class Question < ApplicationRecord

  belongs_to :assessment
  belongs_to :format
  has_many :solutions, inverse_of: :question, dependent: :destroy
  has_many :assets, as: :owner, dependent: :destroy

  validates :content, presence: true
  validates :assessment, presence: true
  # the variant id may be left blank unless the assessment has multiple questions
  validates :variant_id, uniqueness: { scope: :assessment }, allow_blank: true
  validate :ensure_variant_id_present_for_generative

  def variants
    assessment ? assessment.questions.without(self) : []
  end

  protected

  def ensure_variant_id_present_for_generative
    if variants.any? && variant_id.blank?
      errors.add(:variant_id, 'must be present and unique when assessment is generative')
    end
  end

end
