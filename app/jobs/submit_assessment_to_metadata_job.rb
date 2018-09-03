class SubmitAssessmentToMetadataJob < ApplicationJob
  queue_as :default

  def perform(assessment)
    api_result = A15K::Metadata.api.create(assessment)

    api_result.ok? ?
      assessment.update_attributes(submitted_to_metadata_at: Time.current) :
      raise(api_result.errors.join('; '))
  end
end
