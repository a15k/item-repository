class AssessmentSerializer
  include FastJsonapi::ObjectSerializer
  attributes :content,
             :version,
             :visibility,
             :created_at

  has_many :questions
  attribute :format_identifier do |object|
    object.format.identifier
  end
end
