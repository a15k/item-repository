class Format < ApplicationRecord
  include Swagger::Blocks

  validates :name, :description, presence: true

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
