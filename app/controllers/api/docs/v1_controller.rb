class Api::Docs::V1Controller < ApplicationController

  layout 'docs'

  include Swagger::Blocks
  ACCEPT_HEADER = 'application/json'

  swagger_schema :Error do
    property :status_code do
      key :type, :integer
      key :description, "The HTTP status code"
    end
    property :messages do
      key :type, :array
      key :description, "The error messages, if any"
      items do
        key :type, :string
      end
    end
  end

  swagger_root do
    key :swagger, '2.0'
    info do
      key :version, '1.0.0'
      key :title, 'Assessment Network API'
      key :description, <<~DESC
          >
          Stores content for the Assessment Network

          API Version is specified in the URL path as `api/<version>/resource`
          Version will default to the latest if it's ommited

          All endpoints require an API key to be passed in the request header.
          API keys can be obtained by members at www.a15k.org.
      DESC
      key :termsOfService, 'http://a15k.org/terms/'
      contact do
        key :name, 'info@a15k.org'
      end
      license do
        key :name, 'AGPL 3'
      end
    end
    security_definition :api_token do
      key :type, :apiKey
      key :name, :Authorization
      key :in, :header
    end
    key :host, URI.parse(Rails.application.secrets.base_url).host
    key :basePath, '/api/v1'
    key :consumes, [ACCEPT_HEADER]
    key :produces, ['application/json']
  end

  # A list of all classes that have swagger_* declarations.
  SWAGGERED_CLASSES = [
    Api::V1::UserSerializer,
    Api::V1::FormatSerializer,
    Api::V1::AssessmentSerializer,
    Api::V1::VariantSerializer,
    # Api::V1::SolutionSerializer, # commenting until figure out plan for community solutions
    Api::V1::AccessTokenSerializer,
    Api::V1::UsersController,
    Api::V1::FormatsController,
    Api::V1::AssessmentsController,
    Api::V1::AccessTokensController,
    self
  ].freeze

  def index
    respond_to do |format|
      format.html do
        render
      end
      format.json do
        render json: Swagger::Blocks.build_root_json(SWAGGERED_CLASSES)
      end
    end
  end

end
