# coding: utf-8
class Assessment < ApplicationRecord

  belongs_to :member
  has_many :variants, inverse_of: :assessment,
           after_add: :save_fingerprint, after_remove: :save_fingerprint,
           dependent: :destroy

  has_many :other_versions,
           -> (a) { where.not(id: a.id) },
           class_name: 'Assessment',
           foreign_key: :a15k_identifier, primary_key: :a15k_identifier

  # values are stored here temporarily when they're
  # being sent to and from the metadata repository
  attr_accessor :metadata

  before_validation :check_and_initialize_identifiers, on: :create
  before_validation :set_version, on: :create
  before_validation :set_fingerprint

  validates :a15k_identifier, presence: true
  validates :a15k_version, presence: true, uniqueness: { scope: :a15k_identifier }
  validates :source_identifier, presence: true, if: :source_version?
  validates :source_version, uniqueness: { scope: [:member_id, :source_identifier], allow_blank: true }
  validates :fingerprint, uniqueness: true
  validate :ensure_member_matches_other_versions

  after_commit :send_to_metadata_repo, on: :create

  def digest
    Digest::MD5.hexdigest variants.map(&:content).sort.join
  end

  # Put a safety on assessment destruction
  attr_accessor :enable_destroy
  before_destroy :abort_unless_destroy_enabled

  protected

  def check_and_initialize_identifiers
    if a15k_identifier? && other_versions.empty?
      errors.add(:a15k_identifier, "can only be given when a prior version has been assigned its value")
      return
    end

    if a15k_identifier.present? && source_identifier.present?
      if other_versions.first.source_identififer != source_identififer
        errors.add(:source_identifier, "does not match previous values for the given A15k identifier")
      end
      return
    end

    if source_identifier.present?
      a_version_with_same_source_identifier = self.class.where(
        member_id: member_id,
        source_identifier: source_identifier
      ).first

      if a_version_with_same_source_identifier.present?
        self.a15k_identifier = a_version_with_same_source_identifier.a15k_identifier
        return
      end
    end

    self.a15k_identifier = SecureRandom.uuid
  end

  def set_fingerprint
    self.fingerprint = digest
  end

  def save_fingerprint(q)
    update_attributes(fingerprint: digest) if persisted?
  end

  def set_version
    self.a15k_version = other_versions.size + 1
  end

  def ensure_member_matches_other_versions
    if other_versions.any? && member_id != other_versions.last.member_id
      errors.add(:member, 'must be the same as other versions')
    end
  end

  def abort_unless_destroy_enabled
    throw(:abort) unless enable_destroy
  end

  def send_to_metadata_repo
    SubmitAssessmentToMetadata.perform_later(self)
  end
end
