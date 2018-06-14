=begin
#Assessment Network API

#> Stores content for the Assessment Network  API Version is specified in the URL path as `api/<version>/resource` Version will default to the latest if it's ommited  All endpoints require an API key to be passed in the request header. API keys can be obtained by members at www.a15k.org. 

OpenAPI spec version: 1.0.0

Generated by: https://github.com/swagger-api/swagger-codegen.git
Swagger Codegen version: unset

=end

require "uri"

module A15kClient
  class FormatsApi
    attr_accessor :api_client

    def initialize(api_client = ApiClient.default)
      @api_client = api_client
    end

    # create  a format
    # 
    # @param format Format to be created
    # @param [Hash] opts the optional parameters
    # @return [InlineResponse2003]
    def create_format(format, opts = {})
      data, _status_code, _headers = create_format_with_http_info(format, opts)
      return data
    end

    # create  a format
    # 
    # @param format Format to be created
    # @param [Hash] opts the optional parameters
    # @return [Array<(InlineResponse2003, Fixnum, Hash)>] InlineResponse2003 data, response status code and response headers
    def create_format_with_http_info(format, opts = {})
      if @api_client.config.debugging
        @api_client.config.logger.debug "Calling API: FormatsApi.create_format ..."
      end
      # verify the required parameter 'format' is set
      if @api_client.config.client_side_validation && format.nil?
        fail ArgumentError, "Missing the required parameter 'format' when calling FormatsApi.create_format"
      end
      # resource path
      local_var_path = "/formats"

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
      post_body = @api_client.object_to_http_body(format)
      auth_names = ['api_token']
      data, status_code, headers = @api_client.call_api(:POST, local_var_path,
        :header_params => header_params,
        :query_params => query_params,
        :form_params => form_params,
        :body => post_body,
        :auth_names => auth_names,
        :return_type => 'InlineResponse2003')
      if @api_client.config.debugging
        @api_client.config.logger.debug "API called: FormatsApi#create_format\nData: #{data.inspect}\nStatus code: #{status_code}\nHeaders: #{headers}"
      end
      return data, status_code, headers
    end

    # Get all formats
    # List all known formats
    # @param [Hash] opts the optional parameters
    # @return [InlineResponse2002]
    def get_formats(opts = {})
      data, _status_code, _headers = get_formats_with_http_info(opts)
      return data
    end

    # Get all formats
    # List all known formats
    # @param [Hash] opts the optional parameters
    # @return [Array<(InlineResponse2002, Fixnum, Hash)>] InlineResponse2002 data, response status code and response headers
    def get_formats_with_http_info(opts = {})
      if @api_client.config.debugging
        @api_client.config.logger.debug "Calling API: FormatsApi.get_formats ..."
      end
      # resource path
      local_var_path = "/formats"

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
        :return_type => 'InlineResponse2002')
      if @api_client.config.debugging
        @api_client.config.logger.debug "API called: FormatsApi#get_formats\nData: #{data.inspect}\nStatus code: #{status_code}\nHeaders: #{headers}"
      end
      return data, status_code, headers
    end
  end
end
