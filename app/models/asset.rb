class Asset < ApplicationRecord
  include Swagger::Blocks

  belongs_to :owner, polymorphic: true
  belongs_to :created_by, class_name: 'User'

  validates :content_type, presence: true

  swagger_schema :Asset do
    key :required, [:id]
    property :id do
      key :type, :string
      format 'uuid'
    end
  end

end
