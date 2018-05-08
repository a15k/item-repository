class Question < ApplicationRecord
  include Swagger::Blocks

  belongs_to :assessment
  belongs_to :format
  belongs_to :created_by, class_name: 'User'
  has_many :solutions, inverse_of: :question
  has_many :assets, as: :owner

  # TODO add a validate method to format and use it to verify content is well-formed
  validates :content, :created_by, :format, presence: true

  swagger_schema :Question do
    key :required, [:id, :content, :created_at, :format_id]
    property :id do
      key :type, :string
      format 'uuid'
    end
    property :created_at do
      key :type, :string
      key :format, 'date-time'
    end

    property :format_id, { type: :string, format: :uuid  }

    property :solutions do
      key :type, :array
      items do
        key :'$ref', :Solution
      end
    end
    property :assets do
      key :type, :array
      items do
        key :'$ref', :Asset
      end
    end
  end
end
