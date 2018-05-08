require 'strings'

class Format < ApplicationRecord
  include Swagger::Blocks

  belongs_to :created_by, class_name: 'User'

  validates :identifier, :name, :description, :created_by, presence: true
  validates :identifier, uniqueness: true

  before_validation :set_identifier_from_name

  def set_identifier_from_name
    self.identifier = StringsHelper.code_identifier(name, padding: false)
  end

  swagger_schema :Format do
    key :required, [:id, :name, :description]
    property :id do
      key :type, :string
      format 'uuid'
    end
    property :name do
      key :type, :string
    end
    property :description do
      key :type, :string
    end
  end
end
