# coding: utf-8
module Api
  module V1

    class AssessmentSerializer < Serializer

      swagger_schema :Assessment do
        key :description, "The umbrella record for all things related to an exercises that a student could work, including its stem, answer, solutions, and variants"
        key :required, [:id, :version, :visibility, :content, :created_at]
        property :id,           type: :string, format: :uuid
        property :created_at,   type: :string, format: 'date-time'
      end

      property :id,
               type: :string,
               format: :uuid,
               description: 'A unique value that can be used to link the assessment back to the contributors copy'

      property :identifier,
               type: :string,
               description: "An unique contributed-provided identifier that can be used to link the assessment back to the contributor's original version"

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

      property :created_at,
               type: :string,
               format: 'Date'

      property :member, document: false, readable: false,
               reader: ->(user_options:, **) {
        new_record? ? user_options[:current_member] : nil
      }

      property :metadata,
               reader: ->(input:, **) { input[:metadata] ? input[:metadata].to_unsafe_h : nil },
               description: 'Additional searchable metadata to be associated with the assessment' do |doc|
        doc.property :tags do
          key :description, 'A list of tags to mark the assessment with'
          key :type, :array
          items do
            key :type, :string
          end
        end

      end

      property :questions,
               collection: true,
               extend: QuestionSerializer,
               class: Question do |doc|
        doc.key :type, :array
        doc.items do
          key :'$ref', :Question
        end
      end


    end

  end
end
