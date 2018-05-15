require 'strings'

class Format < ApplicationRecord

  belongs_to :created_by, class_name: 'User'

  validates :identifier, :name, :specification, :created_by, presence: true
  validates :identifier, uniqueness: true

  before_validation :set_identifier_from_name

  def set_identifier_from_name
    self.identifier = StringsHelper.code_identifier(name, padding: false)
  end

end
