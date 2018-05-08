# coding: utf-8
class Api::V1::FormatsController < ApiController

  include Swagger::Blocks

  swagger_path '/formats' do
    operation :get do
      key :summary, 'Get all formats'
      key :description, 'List all known formats'
      key :operationId, 'getFormats'
      security do
        key :api_token, []
      end
      key :tags, ['Formats']

      extend Api::SwaggerResponses

      success_schema(model: 'Format', format: :array)
    end
  end
  def index
    render api_response data: Format.all
  end

  swagger_schema :FormatInput do
    allOf do
      schema do
        key :required, [:name, :description]

        property :name,
                 type: :string,
                 description: 'The name of the format'

        property :description,
                 type: :string,
                 description: 'A longer description that fully explains the format'

      end
    end
  end

  swagger_path '/formats' do
    operation :post do
      key :summary, 'create  a format'
      key :operationId, 'createFormat'
      security do
        key :api_token, []
      end
      key :tags, ['Formats']
      parameter do
        key :paramType, :body
        key :name, :name
        key :description, 'The name of the format'
        key :required, true
      end
      parameter do
        key :name, :format
        key :in, :body
        key :description, 'Format to be created'
        key :required, true
        schema do
          key :'$ref', :FormatInput
        end
      end
      extend Api::SwaggerResponses
      success_schema(model: 'Format')
    end
  end

  def create
    format_data = Api::V1::Bindings::FormatInput.new(
      request.parameters.to_hash
    ).to_hash.deep_symbolize_keys

    format_data[:created_by] = current_user

    format = Format.new(format_data)
    render api_response data: format, success: format.save
  end

end
