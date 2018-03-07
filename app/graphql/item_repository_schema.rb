ItemRepositorySchema = GraphQL::Schema.define do
  instrument(:field, GraphQL::Pundit::Instrumenter.new)

  mutation(Types::MutationType)
  query(Types::QueryType)
end


# disabled so we get stack traces while learning graphql


# GraphQL::Errors.configure(ItemRepositorySchema) do
#   rescue_from ActiveRecord::RecordNotFound do |exception|
#     nil # TODO discuss if this is the appropriate response
#   end

#   rescue_from ActiveRecord::RecordInvalid do |exception|
#     GraphQL::ExecutionError.new(exception.record.errors.full_messages.join("\n"))
#   end

#   rescue_from StandardError do |exception|
#     GraphQL::ExecutionError.new("Please try to execute the query for this field later")
#   end
# end
