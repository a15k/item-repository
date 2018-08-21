# coding: utf-8
module Api
  module V1

    class MemberSerializer < Serializer
      swagger_schema :Member do
        key :description, "An organization that belongs to the A15K network"
        key :required, [:id, :name, :website]
      end

      property :id,
               type: :string,
               format: :uuid,
               description: 'A unique value that can be used to link the member to assessments'

      property :name,
               type: :string,
               description: "The name of the member's organization"

    end
  end
end
