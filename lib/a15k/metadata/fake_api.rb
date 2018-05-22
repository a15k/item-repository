module A15K::Metadata
  class FakeApi
    include AssessmentToMetadata

    @@created = {}

    def initialize(user:)
      @user = user
    end

    def create(assessment)
      @@created[assessment.id] = OpenStruct.new(
        content: ::Api::V1::AssessmentSerializer.new(assessment).to_json
      )
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

  end
end
