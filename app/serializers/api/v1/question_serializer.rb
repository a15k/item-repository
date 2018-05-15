module Api
  module V1

    class QuestionSerializer < Roar::Decorator
      include Roar::JSON
      include Swagger::Blocks

      property :id
      property :content
      property :variant
      property :created_at
      property :created_by,
               reader: ->(user_options:, **) {
        new_record? ? user_options[:current_user] : nil
      }
      property :format_id
      collection :solutions, extend: SolutionSerializer, class: Solution
      collection :assets, extend: QuestionSerializer, class: Question

      swagger_schema :Question do
        key :required, [:content, :created_at, :format_id]
        key :description, <<~EOS
      The container for all of the content needed to present an assessment and to grade it. E.g. for a multiple-choice
      assessment, the question would contain the stem, the answer choices, and the correct choice would be flagged.

      Assessments typically only have one question. Multiple questions are allowed to support generative assessments.
      A generative assessment is a single assessment that has many variants, which are often randomly generated.
      Typically, the author of a generative assessment uses a small amount of code to create many variants of the same
      question where all of the numbers change between variants. Because these variants are essentially the same one
      original question, we bundle them all under one Assessment.
    EOS

        property :format_id,  type: :string, format: :uuid,
                 description: 'The uuid of a previously registered format'

        property :variant,    type: :string,
                 description: 'Identifies which variant of a generative item this question is. Only required for generative items.'

        property :content,    type: :string,
                 description: "The content of the question. The formatting the the content is indicated by the assessment's linked format"

        # note: the hash syntax doesnt work because you can't set the items
        # property :solutions, type: :array, :'$ref' => :Solution
        property :solutions do
          key :type, :array
          items do
            key :'$ref', :Solution
          end
        end
      end

    end
  end
end
