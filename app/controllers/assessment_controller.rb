class AssessmentController < ApplicationController

  def preview
    @assessment_id = params[:id]
    # Just pick one variant
    variant = Variant.where(assessment_id: @assessment_id).first
    @preview_html = variant.preview_html
  end

end
