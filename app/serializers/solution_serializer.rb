class SolutionSerializer < Roar::Decorator
  include Roar::JSON

  property :id
  property :content
  property :created_at
  property :varient
  property :format_id
  property :created_at
  property :created_by,
           reader: ->(user_options:, **) {
    new_record? ? user_options[:current_user] : nil
  }
  collection :assets, extend: QuestionSerializer, class: Question
end
