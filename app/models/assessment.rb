# coding: utf-8
class Assessment < ApplicationRecord

  belongs_to :member
  has_many :questions, inverse_of: :assessment,
           after_add: :save_fingerprint, after_remove: :save_fingerprint

  has_many :other_versions,
           -> (a) { where.not(id: a.id) },
           class_name: 'Assessment',
           foreign_key: :identifier, primary_key: :identifier

  enum visibility: %i[internal external]

  before_validation :set_fingerprint
  before_validation :set_version, on: :create

  validates :version, uniqueness: { scope: :identifier }
  validates :fingerprint, uniqueness: true #{ scope: :member_id }
  validate :ensure_member_matches_other_versions

  def digest
    digest = Digest::MD5.new
    questions.each { |q| digest << q.content }
    digest.hexdigest
  end

  protected

  def set_fingerprint
    self.fingerprint = digest
  end

  def save_fingerprint(q)
    update_attributes(fingerprint: digest)
  end

  def set_version
    self.version = other_versions.size + 1
  end

  def ensure_member_matches_other_versions
    if other_versions.any? && member_id != other_versions.last.member_id
      errors.add(:member, 'must be the same as other versions')
    end
  end
end
