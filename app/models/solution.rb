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

    key :description, <<~EOS
       A walkthrough of how to answer the question. This is often some prose combined with math formulas or diagrams.
       A Solution is not the answer to a question (e.g. it isn't the (a), (b), and (c) answers of a multiple choice question.)

       Solutions are recommended but not required when contributing assessments. Additionally, other members may
       contribute solutions to your assessments without involving you.
    EOS

    property :format_id,  type: :string, format: :uuid, description: 'The uuid of a previously registered format'

    property :content, type: :string, description: "A walkthrough of how to answer the question.  The formatting the the content is indicated by the assessment's linked format"
  end

end
