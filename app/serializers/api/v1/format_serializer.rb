module Api
  module V1

    class FormatSerializer < Serializer
      swagger_schema :Format do
        key :description, 'Formats define how assessments are encoded'
        key :required, [:id, :name, :specification]
      end

      property :id, type: String, format: 'uuid'
      property :name, type: String, description: 'A short description of the format'
      property :specification, type: :string, specification: 'A comprehensive description of the format'

      property :created_by,
               document: false,
               readable: false,
               reader: ->(user_options:, **) {
        new_record? ? user_options[:current_user] : nil
      }

    end
  end
end
