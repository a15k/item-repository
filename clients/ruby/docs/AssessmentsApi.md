# A15kClient::AssessmentsApi

All URIs are relative to *https://null/api*

Method | HTTP request | Description
------------- | ------------- | -------------
[**create_assessment**](AssessmentsApi.md#create_assessment) | **POST** /assessment | create an assessment
[**get_assessment**](AssessmentsApi.md#get_assessment) | **GET** /assessment/{id} | Retrieve an assessment


# **create_assessment**
> InlineResponse2001 create_assessment(assessment)

create an assessment

### Example
```ruby
# load the gem
require 'a15k_client'
# setup authorization
A15kClient.configure do |config|
  # Configure API key authorization: api_token
  config.api_key['api_token'] = 'YOUR API KEY'
  # Uncomment the following line to set a prefix for the API key, e.g. 'Bearer' (defaults to nil)
  #config.api_key_prefix['api_token'] = 'Bearer'
end

api_instance = A15kClient::AssessmentsApi.new

assessment = A15kClient::AssessmentInput.new # AssessmentInput | Assessment to be created


begin
  #create an assessment
  result = api_instance.create_assessment(assessment)
  p result
rescue A15kClient::ApiError => e
  puts "Exception when calling AssessmentsApi->create_assessment: #{e}"
end
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **assessment** | [**AssessmentInput**](AssessmentInput.md)| Assessment to be created | 

### Return type

[**InlineResponse2001**](InlineResponse2001.md)

### Authorization

[api_token](../README.md#api_token)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json



# **get_assessment**
> InlineResponse2002 get_assessment

Retrieve an assessment

### Example
```ruby
# load the gem
require 'a15k_client'
# setup authorization
A15kClient.configure do |config|
  # Configure API key authorization: api_token
  config.api_key['api_token'] = 'YOUR API KEY'
  # Uncomment the following line to set a prefix for the API key, e.g. 'Bearer' (defaults to nil)
  #config.api_key_prefix['api_token'] = 'Bearer'
end

api_instance = A15kClient::AssessmentsApi.new

begin
  #Retrieve an assessment
  result = api_instance.get_assessment
  p result
rescue A15kClient::ApiError => e
  puts "Exception when calling AssessmentsApi->get_assessment: #{e}"
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



