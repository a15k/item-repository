class AssessmentSerializer < Roar::Decorator
  include Roar::JSON


  property :id
  property :identifier
  property :version
  property :visibility
  property :format_id
  property :created_at
  property :created_by,
           reader: ->(user_options:, **) {
    new_record? ? user_options[:current_user] : nil
  }
  collection :questions, extend: QuestionSerializer, class: Question
end
