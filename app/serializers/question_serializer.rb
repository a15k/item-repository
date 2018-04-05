class QuestionSerializer
  include FastJsonapi::ObjectSerializer
  attributes :content, :created_at, :varient, :format_id

  has_many :assets
  has_many :solutions
end
