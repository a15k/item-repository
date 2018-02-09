Types::Assessment = GraphQL::ObjectType.define do
  name "Assessment"
  field :id, !types.ID
  field :license, !Types::License do
    description "License that applies to assesment"
  end
  field :organization, !Types::OrganizationType do
    description "Organization that contributed assessment"
  end
end
