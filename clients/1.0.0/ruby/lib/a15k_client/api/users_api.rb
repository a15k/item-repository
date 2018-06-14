=begin
#Assessment Network API

#> Stores content for the Assessment Network  API Version is specified in the URL path as `api/<version>/resource` Version will default to the latest if it's ommited  All endpoints require an API key to be passed in the request header. API keys can be obtained by members at www.a15k.org. 

OpenAPI spec version: 1.0.0

Generated by: https://github.com/swagger-api/swagger-codegen.git
Swagger Codegen version: unset

=end

require "uri"

module A15kClient
  class UsersApi
    attr_accessor :api_client

    def initialize(api_client = ApiClient.default)
      @api_client = api_client
    end

    # add a newly created user account to a membership
    # 
    # @param email email of user to join to membership
    # @param role role to grant to user
    # @param [Hash] opts the optional parameters
    # @return [InlineResponse2001]
    def claim_user(email, role, opts = {})
      data, _status_code, _headers = claim_user_with_http_info(email, role, opts)
      return data
    end

    # add a newly created user account to a membership
    # 
    # @param email email of user to join to membership
    # @param role role to grant to user
    # @param [Hash] opts the optional parameters
    # @return [Array<(InlineResponse2001, Fixnum, Hash)>] InlineResponse2001 data, response status code and response headers
    def claim_user_with_http_info(email, role, opts = {})
      if @api_client.config.debugging
        @api_client.config.logger.debug "Calling API: UsersApi.claim_user ..."
      end
      # verify the required parameter 'email' is set
      if @api_client.config.client_side_validation && email.nil?
        fail ArgumentError, "Missing the required parameter 'email' when calling UsersApi.claim_user"
      end
      # verify the required parameter 'role' is set
      if @api_client.config.client_side_validation && role.nil?
        fail ArgumentError, "Missing the required parameter 'role' when calling UsersApi.claim_user"
      end
      # resource path
      local_var_path = "/users/add".sub('{' + 'email' + '}', email.to_s)

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
      post_body = @api_client.object_to_http_body(role)
      auth_names = ['api_token']
      data, status_code, headers = @api_client.call_api(:POST, local_var_path,
        :header_params => header_params,
        :query_params => query_params,
        :form_params => form_params,
        :body => post_body,
        :auth_names => auth_names,
        :return_type => 'InlineResponse2001')
      if @api_client.config.debugging
        @api_client.config.logger.debug "API called: UsersApi#claim_user\nData: #{data.inspect}\nStatus code: #{status_code}\nHeaders: #{headers}"
      end
      return data, status_code, headers
    end

    # remove a user from membership
    # 
    # @param [Hash] opts the optional parameters
    # @return [InlineResponse2001]
    def delete_user(opts = {})
      data, _status_code, _headers = delete_user_with_http_info(opts)
      return data
    end

    # remove a user from membership
    # 
    # @param [Hash] opts the optional parameters
    # @return [Array<(InlineResponse2001, Fixnum, Hash)>] InlineResponse2001 data, response status code and response headers
    def delete_user_with_http_info(opts = {})
      if @api_client.config.debugging
        @api_client.config.logger.debug "Calling API: UsersApi.delete_user ..."
      end
      # resource path
      local_var_path = "/users/{id}"

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
      data, status_code, headers = @api_client.call_api(:DELETE, local_var_path,
        :header_params => header_params,
        :query_params => query_params,
        :form_params => form_params,
        :body => post_body,
        :auth_names => auth_names,
        :return_type => 'InlineResponse2001')
      if @api_client.config.debugging
        @api_client.config.logger.debug "API called: UsersApi#delete_user\nData: #{data.inspect}\nStatus code: #{status_code}\nHeaders: #{headers}"
      end
      return data, status_code, headers
    end

    # Get all users for the membership
    # List all users
    # @param [Hash] opts the optional parameters
    # @return [InlineResponse200]
    def get_users(opts = {})
      data, _status_code, _headers = get_users_with_http_info(opts)
      return data
    end

    # Get all users for the membership
    # List all users
    # @param [Hash] opts the optional parameters
    # @return [Array<(InlineResponse200, Fixnum, Hash)>] InlineResponse200 data, response status code and response headers
    def get_users_with_http_info(opts = {})
      if @api_client.config.debugging
        @api_client.config.logger.debug "Calling API: UsersApi.get_users ..."
      end
      # resource path
      local_var_path = "/users"

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
        :return_type => 'InlineResponse200')
      if @api_client.config.debugging
        @api_client.config.logger.debug "API called: UsersApi#get_users\nData: #{data.inspect}\nStatus code: #{status_code}\nHeaders: #{headers}"
      end
      return data, status_code, headers
    end

    # alter a user
    # 
    # @param role role to grant to user
    # @param [Hash] opts the optional parameters
    # @return [InlineResponse2001]
    def update_user(role, opts = {})
      data, _status_code, _headers = update_user_with_http_info(role, opts)
      return data
    end

    # alter a user
    # 
    # @param role role to grant to user
    # @param [Hash] opts the optional parameters
    # @return [Array<(InlineResponse2001, Fixnum, Hash)>] InlineResponse2001 data, response status code and response headers
    def update_user_with_http_info(role, opts = {})
      if @api_client.config.debugging
        @api_client.config.logger.debug "Calling API: UsersApi.update_user ..."
      end
      # verify the required parameter 'role' is set
      if @api_client.config.client_side_validation && role.nil?
        fail ArgumentError, "Missing the required parameter 'role' when calling UsersApi.update_user"
      end
      # resource path
      local_var_path = "/users/{id}"

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
      post_body = @api_client.object_to_http_body(role)
      auth_names = ['api_token']
      data, status_code, headers = @api_client.call_api(:PUT, local_var_path,
        :header_params => header_params,
        :query_params => query_params,
        :form_params => form_params,
        :body => post_body,
        :auth_names => auth_names,
        :return_type => 'InlineResponse2001')
      if @api_client.config.debugging
        @api_client.config.logger.debug "API called: UsersApi#update_user\nData: #{data.inspect}\nStatus code: #{status_code}\nHeaders: #{headers}"
      end
      return data, status_code, headers
    end
  end
end
