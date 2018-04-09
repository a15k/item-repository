class QuestionSerializer
  include FastJsonapi::ObjectSerializer
  attributes :content, :created_at, :varient

  has_many :assets
  has_many :solutions

  attribute :format_identifier do |object|
    object.format.identifier
  end
end
