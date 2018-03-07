# frozen_string_literal: true

module Mutations
  module Assessment
    Create = GraphQL::Relay::Mutation.define do
      name "CreateAssessment"

      input_field :license_id, types.ID do
        description 'Identifier for a license'
      end

      return_type Types::Assessment

      resolve ->(_, input, ctx) {
        user = ctx[:current_user]
        ::Assessment.create!(
          organization: user.organization,
          license: License.find(input.license_id)
        )
      }
    end
  end
end
