# coding: utf-8
class Assessment < ApplicationRecord

  belongs_to :member
  has_many :questions, inverse_of: :assessment
  has_many :other_versions,
           -> (a) { where.not(id: a.id) },
           class_name: 'Assessment',
           foreign_key: :identifier, primary_key: :identifier


  enum visibility: %i[internal external]

  validates :version, uniqueness: { scope: :identifier }

  before_validation :set_version, on: :create
  validate :ensure_member_matches_other_versions

  protected

  def set_version
    self.version = other_versions.size + 1
  end

  def ensure_member_matches_other_versions
    if other_versions.any? && member_id != other_versions.last.member_id
      errors.add(:member, 'must be the same as other versions')
    end
  end

end
