Types::OrganizationType = GraphQL::ObjectType.define do
  name "Organization"
  field :id, !types.ID
  field :name, !types.String do
    description "Name of organization"
  end
  field :website, types.String do
    description "Website of organization"
  end
end
