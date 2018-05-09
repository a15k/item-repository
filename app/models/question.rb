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
    key :required, [:content, :created_at, :format_id]
    property :format_id,  type: :string, format: :uuid
    property :content,    type: :string
    property :solutions,  type: :array, '$ref': :Solution
  end
end
