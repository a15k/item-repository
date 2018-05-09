require 'strings'

class Format < ApplicationRecord
  include Swagger::Blocks

  belongs_to :created_by, class_name: 'User'

  validates :identifier, :name, :specification, :created_by, presence: true
  validates :identifier, uniqueness: true

  before_validation :set_identifier_from_name

  def set_identifier_from_name
    self.identifier = StringsHelper.code_identifier(name, padding: false)
  end

  swagger_schema :Format do
    key :required, [:id, :name, :specification]
    property :id, type: :string, format: 'uuid'

    property :name, type: :string, description: 'A short description of the format'

    property :specification, type: :string, specification: 'A comprehensive description of the format'

  end
end
