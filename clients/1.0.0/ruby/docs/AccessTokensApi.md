# A15kClient::AccessTokensApi

All URIs are relative to *https://null/api/v1*

Method | HTTP request | Description
------------- | ------------- | -------------
[**create_token**](AccessTokensApi.md#create_token) | **POST** /access_tokens | create  a token
[**get_tokens**](AccessTokensApi.md#get_tokens) | **GET** /access_tokens | Get all tokens
[**update_token**](AccessTokensApi.md#update_token) | **PUT** /access_tokens/{id} | update  a token


# **create_token**
> InlineResponse2006 create_token(token)

create  a token

### Example
```ruby
# load the gem
require 'a15k_client'
# setup authorization
A15kClient.configure do |config|
  # Configure API key authorization: api_token
  config.api_key['Authorization'] = 'YOUR API KEY'
  # Uncomment the following line to set a prefix for the API key, e.g. 'Bearer' (defaults to nil)
  #config.api_key_prefix['Authorization'] = 'Bearer'
end

api_instance = A15kClient::AccessTokensApi.new

token = A15kClient::AccessToken.new # AccessToken | Access Token to be created


begin
  #create  a token
  result = api_instance.create_token(token)
  p result
rescue A15kClient::ApiError => e
  puts "Exception when calling AccessTokensApi->create_token: #{e}"
end
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **token** | [**AccessToken**](AccessToken.md)| Access Token to be created | 

### Return type

[**InlineResponse2006**](InlineResponse2006.md)

### Authorization

[api_token](../README.md#api_token)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json



# **get_tokens**
> InlineResponse2005 get_tokens

Get all tokens

List all known tokens

### Example
```ruby
# load the gem
require 'a15k_client'
# setup authorization
A15kClient.configure do |config|
  # Configure API key authorization: api_token
  config.api_key['Authorization'] = 'YOUR API KEY'
  # Uncomment the following line to set a prefix for the API key, e.g. 'Bearer' (defaults to nil)
  #config.api_key_prefix['Authorization'] = 'Bearer'
end

api_instance = A15kClient::AccessTokensApi.new

begin
  #Get all tokens
  result = api_instance.get_tokens
  p result
rescue A15kClient::ApiError => e
  puts "Exception when calling AccessTokensApi->get_tokens: #{e}"
end
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**InlineResponse2005**](InlineResponse2005.md)

### Authorization

[api_token](../README.md#api_token)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json



# **update_token**
> InlineResponse2006 update_token(token)

update  a token

### Example
```ruby
# load the gem
require 'a15k_client'
# setup authorization
A15kClient.configure do |config|
  # Configure API key authorization: api_token
  config.api_key['Authorization'] = 'YOUR API KEY'
  # Uncomment the following line to set a prefix for the API key, e.g. 'Bearer' (defaults to nil)
  #config.api_key_prefix['Authorization'] = 'Bearer'
end

api_instance = A15kClient::AccessTokensApi.new

token = A15kClient::AccessToken.new # AccessToken | Access Token to be updated


begin
  #update  a token
  result = api_instance.update_token(token)
  p result
rescue A15kClient::ApiError => e
  puts "Exception when calling AccessTokensApi->update_token: #{e}"
end
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **token** | [**AccessToken**](AccessToken.md)| Access Token to be updated | 

### Return type

[**InlineResponse2006**](InlineResponse2006.md)

### Authorization

[api_token](../README.md#api_token)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json



