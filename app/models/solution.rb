class Solution < ApplicationRecord
  include Swagger::Blocks

  belongs_to :question
  belongs_to :format
  belongs_to :created_by, class_name: 'User'
  has_many :assets, as: :owner

  # TODO add a validate method to format and use it to verify content is well-formed
  validates :content, :format, presence: true

  swagger_schema :Solution do
    key :required, [:id, :content, :created_at, :varient, :format_id]
    property :id do
      key :type, :string
      format 'uuid'
    end
    property :created_at do
      key :type, :string
      key :format, 'date-time'
    end
    property :variant, { type: :string }
    property :format_id, { type: :string, format: :uuid  }

    property :assets do
      key :type, :array
      items do
        key :'$ref', :Asset
      end
    end
  end

end
