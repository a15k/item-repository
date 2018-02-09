Types::QueryType = GraphQL::ObjectType.define do
  name "Query"

  # Add root-level fields here.
  # They will be entry points for queries on your schema.

  field :organization do
    type Types::OrganizationType
    argument :id, !types.ID
    description "Find organizations"
    resolve ->(obj, args, ctx) {
      Organization.find(args['id'])
    }
  end

  field :assessment do
    type Types::Assessment
    argument :id, !types.ID
    description "Find an assessment"
    resolve ->(obj, args, ctx) {

      Assessment.find(args['id'])
    }
  end

end
