require 'strings'

class Format < ApplicationRecord

  belongs_to :created_by, class_name: 'Member'

  validates :identifier, :name, :specification, :created_by, presence: true
  validates :identifier, uniqueness: true

  before_validation :set_identifier_from_name, on: :create

  def set_identifier_from_name
    return if self.identifier
    identifier = StringsHelper.code_identifier(name, padding: false)
    while Format.where(identifier: identifier).any?
      identifier << 'X'
    end
    self.identifier = identifier
  end

end
