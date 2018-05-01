class QuestionSerializer < Roar::Decorator
  include Roar::JSON

  property :id
  property :content
  property :created_at
  property :created_by,
           reader: ->(user_options:, **) {
    new_record? ? user_options[:current_user] : nil
  }

  property :varient
  property :format_id

  collection :solutions, extend: SolutionSerializer, class: Solution
  collection :assets, extend: QuestionSerializer, class: Question
end
