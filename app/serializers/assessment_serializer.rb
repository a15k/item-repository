class AssessmentSerializer
  include FastJsonapi::ObjectSerializer
  attributes :content,
             :version,
             :visibility,
             :format_id,
             :created_at

  has_many :questions

end
