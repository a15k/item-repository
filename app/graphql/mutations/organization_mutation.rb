# frozen_string_literal: true

module Mutations
  module OrganizationMutation
    Update = GraphQL::Relay::Mutation.define do
      name "updateOrganization"

      input_field :name, types.String do
        description 'Name of organization'
      end

      input_field :website, types.String do
        description 'Website of organization'
      end

      return_type Types::OrganizationType

      resolve ->(organization, args, _ctx) {
        organization.update_attributes!(args.to_h)
        organization
      }
    end
  end
end
