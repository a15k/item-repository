module A15K::Metadata
  module AssessmentToMetadata
    def content_for_assessment(assessment)
      ::Api::V1::AssessmentSerializer.new(assessment).to_json
    end
  end
end
