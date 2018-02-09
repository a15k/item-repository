Types::MutationType = GraphQL::ObjectType.define do
  name "Mutation"

  field :updateOrganization, field: Mutations::OrganizationMutation::Update.field do
    authorize :update, policy: Organization
    scope OrganizationPolicy
  end

  field :createAssessment, field: Mutations::Assessment::Create.field do
    authorize :create, policy: Assessment
  end

end
