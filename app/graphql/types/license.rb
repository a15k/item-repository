Types::License = GraphQL::ObjectType.define do
  name "License"
  field :id, !types.ID
  field :abbreviation, !types.String
  field :url, !types.String
  field :name, !types.String
  field :terms, types.String
end
