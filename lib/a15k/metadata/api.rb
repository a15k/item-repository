require_relative 'json_api'

module A15K::Metadata
  class Api
    include AssessmentToMetadata

    def query(clause, options = {})
      JsonApi::Resource
        .includes(:metadatas)
        .where({ query: clause }.merge(options))
        .all
    end

    def create(assessment)
      resource = JsonApi::Resource.new(
        id: assessment.id,
        uri: "https://a15k.org/api/#{assessment.id}.json",
        resource_type: 'assessment',
        content: content_for_assessment(assessment)
      )
      resource.relationships.format = JsonApi::Format.new(
        id: assessment.questions.first.format.id,
      )
      resource.relationships.application = JsonApi::Application.new(
        id: Rails.application.secrets.metadata_api[:application_uuid]
      )
      resource.save
      errors = resource.last_result_set.errors
      create_metadata(assessment) if errors.none? && assessment.metadata.present?
      ApiResult.new(resource.id, errors)
    end

    def retrieve(assessment)
      JsonApi::Resource.find(assessment.id)
    end

    def update(assessment)
      resource = JsonApi::Resource.find(assessment.id).first
      result = resource.update_attributes(
        content: content_for_assessment(assessment)
      )
      ApiResult.new(assessment.id, result ? [] : resourse.errors)
    end

    def create_metadata(assessment)
      metadata = JsonApi::Metadatas.new(
        resource_id: assessment.id,
        value: assessment.metadata,
      )
      metadata.relationships.format = JsonApi::Format.new(
        id: assessment.questions.first.format.id,
      )
      metadata.save
      ApiResult.new(metadata.id, metadata.last_result_set.errors)
    end
  end
end
