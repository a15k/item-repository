module A15K::Metadata
  class FakeApi
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
  end
end
