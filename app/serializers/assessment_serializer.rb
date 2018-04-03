class AssessmentSerializer
  include FastJsonapi::ObjectSerializer
  attributes :version,
             :visibility
  belongs_to :format
  has_many :questions
  has_many :solutions
end
