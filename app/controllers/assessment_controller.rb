class AssessmentController < ApplicationController

  def preview
    @assessment = Assessment.find(params[:id])
  end

end
