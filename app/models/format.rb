require 'strings'

class Format < ApplicationRecord

  belongs_to :created_by, class_name: 'Member'

  has_many :variants
  has_many :solutions

  validates :identifier, :name, :specification, :created_by, presence: true
  validates :identifier, uniqueness: true

  before_validation :set_identifier_from_name, on: :create

  before_destroy :abort_if_used

  def set_identifier_from_name
    return if self.identifier
    identifier = StringsHelper.code_identifier(name, padding: false)
    while Format.where(identifier: identifier).any?
      identifier << 'X'
    end
    self.identifier = identifier
  end

  protected

  def abort_if_used
    throw(:abort) unless variants.reload.none? && solutions.reload.none?
  end

end
