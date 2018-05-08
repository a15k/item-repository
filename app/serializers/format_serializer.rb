class FormatSerializer < Roar::Decorator
  include Roar::JSON

  property :id, type: String
  property :name
  property :identifier
  property :description
end
