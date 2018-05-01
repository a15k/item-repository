class Api::V1::AssessmentsController < ApiController

  include Swagger::Blocks

  swagger_path '/assessment/{id}' do
    operation :get do
      key :summary, 'Retrieve an assessment'
      key :operationId, 'getAssessment'
      security do
        key :api_token, []
      end
      key :tags, ['Assessments']

      extend Api::SwaggerResponses

      success_schema(model: 'Assessment', format: :array)
    end
  end
  def show
    render api_response data: Assessment.find(params[:id])
  end


  swagger_path '/assessment' do
    operation :post do
      key :summary, 'create an assessment'
      key :operationId, 'createAssessment'
      security do
        key :api_token, []
      end
      key :tags, ['Assessments']

      extend Api::SwaggerResponses
      success_schema(model: 'Assessment')
    end
  end
  def create
    assessment = AssessmentSerializer.new(
      Assessment.new,
    ).from_hash(params, user_options: { current_user: current_user })
    render api_response data: assessment, success: assessment.save
  end


end
