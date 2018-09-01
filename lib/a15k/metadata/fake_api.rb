module A15K::Metadata
  class FakeApi
    include AssessmentToMetadata

    @@created = {}

    def query(clause, options = {})
      assessments = @@created.values.select{|a| a.content.include?(clause) }
      if assessments.none?
        assessments = Variant.where('preview_html like :clause', {clause: "%#{clause}%"}).map do |vv|
          assessment_to_json(vv.assessment)
        end
      end
      assessments
    end

    def create(assessment)
      @@created[assessment.id] = assessment_to_json(assessment)
      create_metadata(assessment) if assessment.metadata.present?
      ApiResult.new(assessment.id)
    end

    def retrieve(assessment)
      found = @@created[assessment.id]
      found ? [found] : []
    end

    def update(assessment)
      found = @@created[assessment.id]
      found.content = content_for_assessment(assessment) if found
      ApiResult.new(assessment.id, found ? [] : ['not found'])
    end

    def assessment_to_json(assessment)
      OpenStruct.new(
        id: assessment.id,
        content: ::Api::V1::AssessmentSerializer.new(assessment).to_json
      )
    end

    def create_metadata(assessment)
      assessment.metadata
    end
  end
end
