# coding: utf-8
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

  swagger_schema :AssessmentInput do
    allOf do
      schema do
        key :required, [:format_id]

        property :identifier,
                 type: :string,
                 description: "A unique identifier for the assessment, uuid is recommended but not required"

        property :format_id,
                 type: :string,
                 format: :uuid,
                 description: 'The uuid of a previously registered format'

        property :version,
                 type: :string,
                 description: 'The version for the assessment, an incrementing number is recommended, but any string value is allowed as long as it‘s unique within the scope of the identifier'

        property :content,
                 type: :string,
                 description: "Content the applies to all questions and solutions.  The formatting the the content is indicated by the assessment's linked format"
        property :visibility,
                 type: :string,
                 format: :uuid,
                 enum: ['internal', 'external'],
                 description: 'If the assessment may be viewed by the public, or only by other a15k members.  Defaults to "internal"'

        property :questions do
          key :type, :array
          items do
            key :type, :object
            key :required, [:format_id, :content]

            property :format_id,
                     type: :string,
                     format: :uuid,
                     required: true,
                     description: 'The uuid of a previously registered format'

            property :content,
                     type: :string,
                     description: "Content of the question. Formatting of the content is indicated by the linked format"

            property :solutions do
              key :type, :array

              items do
                key :type, :object
                key :required, [:format_id, :content]

                property :format_id,
                         type: :string,
                         format: :uuid,
                         required: true,
                         description: 'The uuid of a previously registered format'

                property :content,
                         type: :string,
                         description: "Content of the solution. Formatting of the content is indicated by the linked format"

                property :variant,
                         type: :string,
                         description: 'A unique value shared with multiple solutions, allowing them to be linked together for auto-generated assessments'
              end
            end
          end
        end

      end
    end
  end

  swagger_path '/assessment' do
    operation :post do
      key :summary, 'create an assessment'
      key :operationId, 'createAssessment'
      security do
        key :api_token, []
      end
      key :tags, ['Assessments']
      key :produces, ['application/json']
      extend Api::SwaggerResponses
      success_schema(model: 'Assessment')

      parameter do
        key :name, :assessment
        key :in, :body
        key :description, 'Assessment to be created'
        key :required, true
        schema do
          key :'$ref', :AssessmentInput
        end
      end
      extend Api::SwaggerResponses
      success_schema(model: 'Format')
    end
  end

  def create
    assessment = AssessmentSerializer.new(
      Assessment.new,
    ).from_hash(params, user_options: { current_user: current_user })
    render api_response data: assessment, success: assessment.save
  end


end
