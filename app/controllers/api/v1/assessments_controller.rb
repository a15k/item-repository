# coding: utf-8
class Api::V1::AssessmentsController < ApiController

  include Swagger::Blocks

  swagger_path '/assessments' do
    operation :get do
      key :summary, 'Search for assessments'
      key :operationId, 'searchAssessments'
      security do
        key :api_token, []
      end
      key :tags, ['Assessments']
      parameter name: :query, in: :query, type: :string, required: true,
                description: 'the query string to search for'
      parameter name: :page, in: :query, type: :int, required: false,
                description: 'the page index to return, the first page is 1'
      parameter name: :per_page, in: :query, type: :int, required: false,
                description: 'how many assessments should be returned for a page'

      extend Api::SwaggerResponses
      include_success_schema(model: 'Assessment')
    end
  end
  def index
    if params[:query].blank?
      render api_response(success: false, message: 'must include "query" query parameter')
      return
    end
    result = A15K::Metadata.api.query(
      params.permit(:query, :page, :per_page)
    )
    found = result.as_hash
    assessments = Assessment.includes(:member, :variants).where(id: found.keys)
    assessments.each{ |a|
      a.metadata = {
        tags: (found[a.id].metadatas || [])
          .map{|m| m.value['tags'] }
          .flatten
          .uniq
      }
    }
    render api_response total_count: result.total_count, data: assessments
  end

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
      include_404_schema
      include_success_schema(model: 'Assessment')
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
      include_success_schema(model: 'Assessment')
    end
  end

  def create
    assessment = Api::V1::AssessmentSerializer.new(
      Assessment.new,
    ).from_hash(params, user_options: { current_member: current_member })

    render api_response data: assessment, success: assessment.save
  end

end
