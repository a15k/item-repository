class Assessment < ApplicationRecord
  include Swagger::Blocks

  belongs_to :format
  belongs_to :created_by, class_name: 'User'

  enum visibility: %i[internal external]

  has_many :questions

  validates :format, :created_by, presence: true

  swagger_schema :Assessment do
    key :required, [:id, :version, :visibility, :format_id, :content, :created_at]
    property :id,         type: :string, format: :uuid
    property :created_at, type: :string, format: 'date-time'
    property :identifier, type: :string
    property :version,    type: :string
    property :visibility, type: :string
    property :content,    type: :string
    property :format_id,  type: :string, format: :uuid
    property :questions do
      key :type, :array
      items do
        key :'$ref', :Question
      end
    end
  end
end
