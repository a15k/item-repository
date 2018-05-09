class FormatSerializer < Roar::Decorator
  include Roar::JSON

  property :id, type: String
  property :name
  property :identifier
  property :specification
  property :created_by,
           reader: ->(user_options:, **) {
    new_record? ? user_options[:current_user] : nil
  }
end
