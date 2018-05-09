# coding: utf-8
class Assessment < ApplicationRecord
  include Swagger::Blocks

  belongs_to :format
  belongs_to :created_by, class_name: 'User'

  enum visibility: %i[internal external]

  has_many :questions

  validates :format, :created_by, presence: true

  swagger_schema :Assessment do
    key :description, "The umbrella record for all things related to an exercises that a student could work, including its stem, answer, solutions, and variants"
    key :required, [:id, :version, :visibility, :format_id, :content, :created_at]
    property :id,           type: :string, format: :uuid
    property :created_at,   type: :string, format: 'date-time'

    property :identifier,
             type: :string,
             description: 'A unique value that can be used to link the assessment back to the contributors copy'

    property :version,
             type: :string,
             description: 'The version for the assessment, an incrementing number is recommended, but any string value is allowed as long as it‘s unique within the scope of the identifier'

    property :visibility,
             type: :string,
             enum: ['internal', 'external'],
             description: 'If the assessment may be viewed by the public, or only by other a15k members.  Defaults to "internal"'

    property :preview_html,
             type: :string,
             description: 'If provided, will be used to generate a preview on the a15k website'

    property :format_id,
             type: :string,
             format: :uuid,
             description: 'The uuid of a previously registered format'

    property :questions do
      key :type, :array
      items do
        key :'$ref', :Question
      end
    end
  end
end
