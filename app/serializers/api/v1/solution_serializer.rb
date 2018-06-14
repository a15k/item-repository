module Api
  module V1
    class SolutionSerializer < Serializer
      swagger_schema :Solution do
        key :required, [:content, :created_at, :format_id]

        key :description, <<~EOS
          A walkthrough of how to answer the question.
          This is often some prose combined with math formulas or diagrams.
          A Solution is not the answer to a question (e.g. it isn't the (a), (b),
          and (c) answers of a multiple choice question.)

          Solutions are recommended but not required when contributing assessments. A
          dditionally, other members may contribute solutions to your
          assessments without involving you.
          EOS
      end

      property :id, document: false

      property :content, type: :string, description: "A walkthrough of how to answer the question.  The formatting the the content is indicated by the assessment's linked format"

      property :format_id, type: :string, format: :uuid, description: 'The uuid of a previously registered format'

      property :created_by, document: false, readable: false,
               reader: ->(user_options:, **) {
        new_record? ? user_options[:current_member] : nil
      }

    end

  end
end
