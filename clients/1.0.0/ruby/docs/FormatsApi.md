# A15kClient::FormatsApi

All URIs are relative to *https://null/api/v1*

Method | HTTP request | Description
------------- | ------------- | -------------
[**create_format**](FormatsApi.md#create_format) | **POST** /formats | create  a format
[**get_formats**](FormatsApi.md#get_formats) | **GET** /formats | Get all formats


# **create_format**
> InlineResponse2003 create_format(format)

create  a format

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

api_instance = A15kClient::FormatsApi.new

format = A15kClient::Format.new # Format | Format to be created


begin
  #create  a format
  result = api_instance.create_format(format)
  p result
rescue A15kClient::ApiError => e
  puts "Exception when calling FormatsApi->create_format: #{e}"
end
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **format** | [**Format**](Format.md)| Format to be created | 

### Return type

[**InlineResponse2003**](InlineResponse2003.md)

### Authorization

[api_token](../README.md#api_token)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json



# **get_formats**
> InlineResponse2002 get_formats

Get all formats

List all known formats

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

api_instance = A15kClient::FormatsApi.new

begin
  #Get all formats
  result = api_instance.get_formats
  p result
rescue A15kClient::ApiError => e
  puts "Exception when calling FormatsApi->get_formats: #{e}"
end
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**InlineResponse2002**](InlineResponse2002.md)

### Authorization

[api_token](../README.md#api_token)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json



