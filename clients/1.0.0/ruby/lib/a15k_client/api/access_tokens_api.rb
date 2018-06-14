=begin
#Assessment Network API

#> Stores content for the Assessment Network  API Version is specified in the URL path as `api/<version>/resource` Version will default to the latest if it's ommited  All endpoints require an API key to be passed in the request header. API keys can be obtained by members at www.a15k.org. 

OpenAPI spec version: 1.0.0

Generated by: https://github.com/swagger-api/swagger-codegen.git
Swagger Codegen version: unset

=end

require "uri"

module A15kClient
  class AccessTokensApi
    attr_accessor :api_client

    def initialize(api_client = ApiClient.default)
      @api_client = api_client
    end

    # create  a token
    # 
    # @param token Access Token to be created
    # @param [Hash] opts the optional parameters
    # @return [InlineResponse2006]
    def create_token(token, opts = {})
      data, _status_code, _headers = create_token_with_http_info(token, opts)
      return data
    end

    # create  a token
    # 
    # @param token Access Token to be created
    # @param [Hash] opts the optional parameters
    # @return [Array<(InlineResponse2006, Fixnum, Hash)>] InlineResponse2006 data, response status code and response headers
    def create_token_with_http_info(token, opts = {})
      if @api_client.config.debugging
        @api_client.config.logger.debug "Calling API: AccessTokensApi.create_token ..."
      end
      # verify the required parameter 'token' is set
      if @api_client.config.client_side_validation && token.nil?
        fail ArgumentError, "Missing the required parameter 'token' when calling AccessTokensApi.create_token"
      end
      # resource path
      local_var_path = "/access_tokens"

      # query parameters
      query_params = {}

      # header parameters
      header_params = {}
      # HTTP header 'Accept' (if needed)
      header_params['Accept'] = @api_client.select_header_accept(['application/json'])
      # HTTP header 'Content-Type'
      header_params['Content-Type'] = @api_client.select_header_content_type(['application/json'])

      # form parameters
      form_params = {}

      # http body (model)
      post_body = @api_client.object_to_http_body(token)
      auth_names = ['api_token']
      data, status_code, headers = @api_client.call_api(:POST, local_var_path,
        :header_params => header_params,
        :query_params => query_params,
        :form_params => form_params,
        :body => post_body,
        :auth_names => auth_names,
        :return_type => 'InlineResponse2006')
      if @api_client.config.debugging
        @api_client.config.logger.debug "API called: AccessTokensApi#create_token\nData: #{data.inspect}\nStatus code: #{status_code}\nHeaders: #{headers}"
      end
      return data, status_code, headers
    end

    # Get all tokens
    # List all known tokens
    # @param [Hash] opts the optional parameters
    # @return [InlineResponse2005]
    def get_tokens(opts = {})
      data, _status_code, _headers = get_tokens_with_http_info(opts)
      return data
    end

    # Get all tokens
    # List all known tokens
    # @param [Hash] opts the optional parameters
    # @return [Array<(InlineResponse2005, Fixnum, Hash)>] InlineResponse2005 data, response status code and response headers
    def get_tokens_with_http_info(opts = {})
      if @api_client.config.debugging
        @api_client.config.logger.debug "Calling API: AccessTokensApi.get_tokens ..."
      end
      # resource path
      local_var_path = "/access_tokens"

      # query parameters
      query_params = {}

      # header parameters
      header_params = {}
      # HTTP header 'Accept' (if needed)
      header_params['Accept'] = @api_client.select_header_accept(['application/json'])
      # HTTP header 'Content-Type'
      header_params['Content-Type'] = @api_client.select_header_content_type(['application/json'])

      # form parameters
      form_params = {}

      # http body (model)
      post_body = nil
      auth_names = ['api_token']
      data, status_code, headers = @api_client.call_api(:GET, local_var_path,
        :header_params => header_params,
        :query_params => query_params,
        :form_params => form_params,
        :body => post_body,
        :auth_names => auth_names,
        :return_type => 'InlineResponse2005')
      if @api_client.config.debugging
        @api_client.config.logger.debug "API called: AccessTokensApi#get_tokens\nData: #{data.inspect}\nStatus code: #{status_code}\nHeaders: #{headers}"
      end
      return data, status_code, headers
    end

    # update  a token
    # 
    # @param token Access Token to be updated
    # @param [Hash] opts the optional parameters
    # @return [InlineResponse2006]
    def update_token(token, opts = {})
      data, _status_code, _headers = update_token_with_http_info(token, opts)
      return data
    end

    # update  a token
    # 
    # @param token Access Token to be updated
    # @param [Hash] opts the optional parameters
    # @return [Array<(InlineResponse2006, Fixnum, Hash)>] InlineResponse2006 data, response status code and response headers
    def update_token_with_http_info(token, opts = {})
      if @api_client.config.debugging
        @api_client.config.logger.debug "Calling API: AccessTokensApi.update_token ..."
      end
      # verify the required parameter 'token' is set
      if @api_client.config.client_side_validation && token.nil?
        fail ArgumentError, "Missing the required parameter 'token' when calling AccessTokensApi.update_token"
      end
      # resource path
      local_var_path = "/access_tokens/{id}"

      # query parameters
      query_params = {}

      # header parameters
      header_params = {}
      # HTTP header 'Accept' (if needed)
      header_params['Accept'] = @api_client.select_header_accept(['application/json'])
      # HTTP header 'Content-Type'
      header_params['Content-Type'] = @api_client.select_header_content_type(['application/json'])

      # form parameters
      form_params = {}

      # http body (model)
      post_body = @api_client.object_to_http_body(token)
      auth_names = ['api_token']
      data, status_code, headers = @api_client.call_api(:PUT, local_var_path,
        :header_params => header_params,
        :query_params => query_params,
        :form_params => form_params,
        :body => post_body,
        :auth_names => auth_names,
        :return_type => 'InlineResponse2006')
      if @api_client.config.debugging
        @api_client.config.logger.debug "API called: AccessTokensApi#update_token\nData: #{data.inspect}\nStatus code: #{status_code}\nHeaders: #{headers}"
      end
      return data, status_code, headers
    end
  end
end