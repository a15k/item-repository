class SubmitAssessmentToMetadataJob < ApplicationJob
  queue_as :default

  def perform(assessment)
    A15K::Metadata.api.create(assessment)
    assessment.update_attributes(submitted_to_metadata_at: Time.current)
  end
end
