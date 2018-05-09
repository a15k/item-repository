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
             description: 'A key that links multiple questions together to form variants'

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
