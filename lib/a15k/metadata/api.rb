require_relative 'json_api'

module A15K::Metadata
  class Api

    def initialize(user:)
      @user = user
    end

    def add_assessment(assessment)
#      p assessment.public_json,
      model = JsonApi::Resource.new(
        uuid: assessment.id,
        uri: "https://a15k.org/api/#{assessment.id}.json",
        resource_type: 'assessment',
        content: assessment.public_json.to_json,
      )
      model.relationships.format = JsonApi::Format.new(
        id: assessment.format.id,
      )
      model.relationships.application_user = JsonApi::ApplicationUser.new(
        id: @user.id,
      )
      model.relationships.application = JsonApi::Application.new(
        id: Rails.application.secrets.metadata_api[:application_uuid]
      )
      model.save
      ApiResult.new(model.last_result_set.errors)
    end

  end
end
