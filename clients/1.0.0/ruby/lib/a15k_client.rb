=begin
#Assessment Network API

#> Stores content for the Assessment Network  API Version is specified in the URL path as `api/<version>/resource` Version will default to the latest if it's ommited  All endpoints require an API key to be passed in the request header. API keys can be obtained by members at www.a15k.org. 

OpenAPI spec version: 1.0.0

Generated by: https://github.com/swagger-api/swagger-codegen.git
Swagger Codegen version: 2.3.1

=end

# Common files
require 'a15k_client/api_client'
require 'a15k_client/api_error'
require 'a15k_client/version'
require 'a15k_client/configuration'

# Models
require 'a15k_client/models/access_token'
require 'a15k_client/models/assessment'
require 'a15k_client/models/assessment_metadata'
require 'a15k_client/models/error'
require 'a15k_client/models/format'
require 'a15k_client/models/inline_response_200'
require 'a15k_client/models/inline_response_200_1'
require 'a15k_client/models/inline_response_200_2'
require 'a15k_client/models/inline_response_200_3'
require 'a15k_client/models/inline_response_200_4'
require 'a15k_client/models/inline_response_200_5'
require 'a15k_client/models/inline_response_200_6'
require 'a15k_client/models/solution'
require 'a15k_client/models/user'
require 'a15k_client/models/variant'

# APIs
require 'a15k_client/api/access_tokens_api'
require 'a15k_client/api/assessments_api'
require 'a15k_client/api/formats_api'
require 'a15k_client/api/users_api'

module A15kClient
  class << self
    # Customize default settings for the SDK using block.
    #   A15kClient.configure do |config|
    #     config.username = "xxx"
    #     config.password = "xxx"
    #   end
    # If no block given, return the default Configuration object.
    def configure
      if block_given?
        yield(Configuration.default)
      else
        Configuration.default
      end
    end
  end
end
