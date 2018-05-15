# coding: utf-8
class Api::V1::AssessmentsController < ApiController

  include Swagger::Blocks

  swagger_path '/assessments/{id}' do
    operation :get do
      key :summary, 'Retrieve an assessment'
      key :operationId, 'getAssessment'
      security do
        key :api_token, []
      end
      key :tags, ['Assessments']

      parameter do
        key :name, :id
        key :in, :path
        key :description, 'UUID of assessment to fetch'
        key :required, true
        key :type, :integer
        key :format, :uuid
      end

      extend Api::SwaggerResponses

      success_schema(model: 'Assessment')
    end
  end
  def show
    render api_response data: Assessment.find(params[:id])
  end

  swagger_path '/assessments' do
    operation :post do
      key :summary, 'create an assessment'
      key :operationId, 'createAssessment'
      security do
        key :api_token, []
      end
      key :tags, ['Assessments']
      extend Api::SwaggerResponses
      success_schema(model: 'Assessment')

      parameter do
        key :name, :assessment
        key :in, :body
        key :description, 'Assessment to be created'
        key :required, true
        schema do
          key :'$ref', :Assessment
        end
      end
      extend Api::SwaggerResponses
      success_schema(model: 'Assessment')
    end
  end

  def create
    assessment = Api::V1::AssessmentSerializer.new(
      Assessment.new,
    ).from_hash(params, user_options: { current_user: current_user })
    render api_response data: assessment, success: assessment.save
  end

end
