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
          key :'$ref', :Format
        end
      end
      extend Api::SwaggerResponses
      success_schema(model: 'Format')
    end
  end

  def create
    format = FormatSerializer.new(
      Format.new
    ).from_hash(params, user_options: { current_user: current_user })
    render api_response data: format, success: format.save
  end

end
