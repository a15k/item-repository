module Api
  module V1

    class AccessTokenSerializer < Serializer
      swagger_schema :AccessToken do
        key :description, 'Access Tokens grant access to add/edit/delete resources on behalf of a member'
        key :required, [:id, :name, :specification]
      end

      property :id, type: :string, format: 'uuid'
      property :is_revoked, type: :boolean, description: 'Is the token de-activated and cannot be used'
      property :name, type: :string, description: 'The name assigned to the token so it can be identified'
      property :token, type: :string, writeable: false

      property :member_id,
               document: false,
               readable: false,
               reader: ->(user_options:, **) {
        new_record? ? user_options[:current_member].id : member.id
      }

    end
  end
end
