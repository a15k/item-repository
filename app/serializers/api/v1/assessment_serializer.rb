# coding: utf-8
module Api
  module V1

    class AssessmentSerializer < Serializer

      swagger_schema :Assessment do
        key :description, "The umbrella record for all things related to an assessment."
        key :required, [:id, :a15k_identifier, :a15k_version, :created_at]
        property :id,           type: :string, format: :uuid
        property :created_at,   type: :string, format: 'date-time'
      end

      property :id,
               type: :string,
               format: :uuid,
               description: 'A UUID for this specific assessment version'

      property :source_identifier,
               type: :string,
               description: <<~EOS
                 A member-controlled identifier that is shared between all versions of this assessment in the member's assessment
                 repository (the source).  If contributing a new version of a previous contribution, provide the source_identifier
                 you provided for other versions or the a15k_identifier from those versions.
               EOS

      property :source_version,
               type: :string,
               description: "A member-controlled value identifying this assessment's version in the member's assessment repository (the source)."

      property :a15k_identifier,
               type: :string,
               format: :uuid,
               description: <<~EOS
                 An a15k-provided UUID that is shared between all versions of this assessment within the network.
                 If contributing a new version of a previous contribution, provide this a15k_identifier or the
                 source_identifier you provided for the other versions.
               EOS

      property :a15k_version,
               type: :integer,
               description: "An a15k-provided number identifying which version this assessment is."

      property :created_at,
               type: :string,
               format: 'Date'

      property :member,
               description: 'The member who contributed the assessment. Is only included by the search api and not when assessments are requested by id',
               getter:  ->(**) { association(:member).loaded? ? MemberSerializer.new(member).as_json : nil },
               reader: ->(user_options:, **) {
                 new_record? ? user_options[:current_member] : nil
               }

      property :metadata,
               reader: ->(input:, **) { input[:metadata] ? input[:metadata].to_unsafe_h : nil },
               description: 'A object containing searchable metadata that’s associated with the assessment.  May optionally contain a “tags” property with a list of strings which will be displayed as part of the assessment preview.' do |doc|

        doc.property :tags do
          key :description, 'A list of tags to mark the assessment with'
          key :type, :array
          items do
            key :type, :string
          end
        end

      end

      property :variants,
               collection: true,
               extend: VariantSerializer,
               class: Variant do |doc|
        doc.key :type, :array
        doc.items do
          key :'$ref', :Variant
        end
      end


    end

  end
end
