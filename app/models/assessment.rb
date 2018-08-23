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

  # values are stored here temporarily when they're
  # being sent to and from the metadata repository
  attr_accessor :metadata

  before_validation :set_default_identifier, on: :create
  before_validation :set_version, on: :create
  before_validation :set_fingerprint

  validates :version, uniqueness: { scope: :identifier }
  validates :fingerprint, uniqueness: true # { scope: :member_id } # TODO decide if should be scoped
  validate :ensure_member_matches_other_versions

  after_commit :send_to_metadata_repo, on: :create

  def digest
    Digest::MD5.hexdigest questions.map(&:content).sort.join
  end

  protected

  def set_default_identifier
    self.identifier ||= SecureRandom.uuid
  end

  def set_fingerprint
    self.fingerprint = digest
  end

  def save_fingerprint(q)
    update_attributes(fingerprint: digest) if persisted?
  end

  def set_version
    self.version = other_versions.size + 1
  end

  def ensure_member_matches_other_versions
    if other_versions.any? && member_id != other_versions.last.member_id
      errors.add(:member, 'must be the same as other versions')
    end
  end

  def send_to_metadata_repo
    begin
      A15K::Metadata.api.create(self)
    rescue => e
      Rails.logger.warn "Failed to create metadata for new assessment #{self.id}"
      Rails.logger.warn e
    end
  end
end
