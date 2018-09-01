module Api
  module V1

    class VariantSerializer < Serializer
      swagger_schema :Variant do
        key :required, [:content, :created_at, :format_id]

        key :description, <<~EOS
          The container for all of the content needed to present an assessment and to grade it.
          E.g. for a multiple-choice assessment, the variant would contain the stem,
          the answer choices, and the correct choice would be flagged.

          Assessments typically only have one variant. Multiple variantss are allowed to
          support generative assessments.

          A generative assessment is a single assessment that has many variants,
          which are often randomly generated.

          Typically, the author of a generative assessment uses a small amount of code
          to create many variants of the same question where all of the numbers change
          between variants. Because these variants are essentially the same one
          original question, we bundle them all under one Assessment.
        EOS
      end

      property :id, document: false
      property :format_id,  type: :string, format: :uuid,
               description: 'The uuid of a previously registered format'

      property :variant_id, type: :string,
               description: 'Identifies which variant of a generative item this question is. Only required for generative items.'

      property :content,    type: :string,
               description: "The content of the variant. The formatting the the content is indicated by the assessment's linked format"

      property :solutions, collection: true, extend: SolutionSerializer, class: Solution do |doc|
        doc.key :type, :array
        doc.items do
          key :'$ref', :Solution
        end
      end

    end
  end
end
