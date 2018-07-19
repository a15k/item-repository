class Api::V1::AccessTokensController < ApiController

  include Swagger::Blocks

  swagger_path '/access_tokens' do
    operation :get do
      key :summary, 'Get all tokens'
      key :description, 'List all known tokens'
      key :operationId, 'getTokens'
      security do
        key :api_token, []
      end
      key :tags, ['AccessTokens']

      extend Api::SwaggerResponses
      include_404_schema
      include_success_schema(model: 'AccessToken', format: :array)
    end
  end

  def index
    render api_response data: current_member.access_tokens
  end

  swagger_path '/access_tokens' do
    operation :post do
      key :summary, 'create  a token'
      key :operationId, 'createToken'
      security do
        key :api_token, []
      end
      key :tags, ['AccessTokens']
      parameter do
        key :name, :token
        key :in, :body
        key :description, 'Access Token to be created'
        key :required, true
        schema do
          key :'$ref', :AccessToken
        end
      end
      extend Api::SwaggerResponses
      include_success_schema(model: 'AccessToken')
    end
  end

  def create
    token = Api::V1::AccessTokenSerializer.new(
      AccessToken.new
    ).from_hash(params, user_options: { current_member: current_member })
    render api_response data: token, success: token.save
  end

  swagger_path '/access_tokens/{id}' do
    operation :put do
      key :summary, 'update  a token'
      key :operationId, 'updateToken'
      security do
        key :api_token, []
      end
      key :tags, ['AccessTokens']
      parameter do
        key :name, :token
        key :in, :body
        key :description, 'Access Token to be updated'
        key :required, true
        schema do
          key :'$ref', :AccessToken
        end
      end
      extend Api::SwaggerResponses
      include_404_schema
      include_success_schema(model: 'AccessToken')
    end
  end

  def update
    token = Api::V1::AccessTokenSerializer.new(
      current_member.access_tokens.find(params[:id])
    ).from_hash(params, user_options: { current_member: current_member })
    render api_response data: token, success: token.save
  end

end
