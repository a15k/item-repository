# A15kClient::AssessmentsApi

All URIs are relative to *https://null/api/v1*

Method | HTTP request | Description
------------- | ------------- | -------------
[**create_assessment**](AssessmentsApi.md#create_assessment) | **POST** /assessments | create an assessment
[**get_assessment**](AssessmentsApi.md#get_assessment) | **GET** /assessments/{id} | Retrieve an assessment


# **create_assessment**
> InlineResponse2002 create_assessment(assessment)

create an assessment

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

[**InlineResponse2002**](InlineResponse2002.md)

### Authorization

[api_token](../README.md#api_token)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json



# **get_assessment**
> InlineResponse2002 get_assessment(id)

Retrieve an assessment

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

api_instance = A15kClient::AssessmentsApi.new

id = 56 # Integer | UUID of assessment to fetch


begin
  #Retrieve an assessment
  result = api_instance.get_assessment(id)
  p result
rescue A15kClient::ApiError => e
  puts "Exception when calling AssessmentsApi->get_assessment: #{e}"
end
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **Integer**| UUID of assessment to fetch | 

### Return type

[**InlineResponse2002**](InlineResponse2002.md)

### Authorization

[api_token](../README.md#api_token)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json



