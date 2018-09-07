module A15K::Metadata
  class FakeApi
    include AssessmentToMetadata

    @@created = {}

    def query(query)
      result = QueryResult.new
      q = query[:query]
      page = query[:page] ? query[:page].to_i : 1
      per_page = query[:per_page] ? query[:per_page].to_i : 10
      query = Assessment
                .joins(:variants)
                .includes(:variants)
                .where(
                  variants: Variant.where(
                    'preview_html like :clause or content like :clause', {clause: "%#{q}%"}
                  )
                )
      result.total_count = query.dup.count
      result.assessments = query
                             .limit(per_page)
                             .offset(per_page * (page - 1))
                             .map{ |a| assessment_to_json(a) }
      result
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
