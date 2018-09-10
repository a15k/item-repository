class AssessmentController < ApplicationController

  def preview
    @title = "Assessment preview of #{params[:id]}"
    # Just pick one variant
    variant = Variant.where(assessment_id: params[:id]).first
    @preview_html = variant.preview_html
  end

  def format
    format = Format.find(params[:id])
    @preview_html = format.specification
    @title = "Format preview for #{format.identifier}"
    render :preview
  end

end
