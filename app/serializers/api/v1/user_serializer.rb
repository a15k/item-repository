module Api
  module V1
    class UserSerializer < Serializer
      swagger_schema :User do
        key :description, "A user who can login and use the AssessmentNetwork interactively"
        key :required, [:id, :role]
      end

      property :id,   type: :string, format: :uuid
      property :role, type: :string, enum: ['power_user', 'standard_user']
      property :username, type: :string, getter: ->(*) { account.username }
      property :name, type: :string, getter: ->(*) { account.name }
    end
  end
end
