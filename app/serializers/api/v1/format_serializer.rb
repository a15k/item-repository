module Api
  module V1

    class FormatSerializer < Roar::Decorator
      include Roar::JSON
      include Swagger::Blocks

      property :id, type: String
      property :name
      property :identifier
      property :specification
      property :created_by,
               reader: ->(user_options:, **) {
        new_record? ? user_options[:current_user] : nil
      }

      swagger_schema :Format do
        key :required, [:id, :name, :specification]
        property :id, type: :string, format: 'uuid'

        property :name, type: :string, description: 'A short description of the format'

        property :specification, type: :string, specification: 'A comprehensive description of the format'      end

    end
  end
end
