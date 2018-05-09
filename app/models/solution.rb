class Solution < ApplicationRecord
  include Swagger::Blocks

  belongs_to :question
  belongs_to :format
  belongs_to :created_by, class_name: 'User'
  has_many :assets, as: :owner

  # TODO add a validate method to format and use it to verify content is well-formed
  validates :content, :format, presence: true

  swagger_schema :Solution do
    key :required, [:content, :created_at, :format_id]
    property :variant,    type: :string
    property :format_id,  type: :string, format: :uuid
    property :content,    type: :string
  end

end
