class AssessmentSerializer
  include FastJsonapi::ObjectSerializer
  attributes :content,
             :version,
             :visibility,
             :created_at

  belongs_to :format
  has_many :questions
end
