# AssessmentsApi

All URIs are relative to *https://null/api/v1*

Method | HTTP request | Description
------------- | ------------- | -------------
[**createAssessment**](AssessmentsApi.md#createAssessment) | **POST** /assessments | create an assessment
[**getAssessment**](AssessmentsApi.md#getAssessment) | **GET** /assessments/{id} | Retrieve an assessment
[**searchAssessments**](AssessmentsApi.md#searchAssessments) | **GET** /assessments | Search for assessments


<a name="createAssessment"></a>
# **createAssessment**
> InlineResponse2004 createAssessment(assessment)

create an assessment

### Example
```java
// Import classes:
//import org.a15k.client.v1.client.ApiClient;
//import org.a15k.client.v1.client.ApiException;
//import org.a15k.client.v1.client.Configuration;
//import org.a15k.client.v1.client.auth.*;
//import org.a15k.client.v1.client.api.AssessmentsApi;

ApiClient defaultClient = Configuration.getDefaultApiClient();

// Configure API key authorization: api_token
ApiKeyAuth api_token = (ApiKeyAuth) defaultClient.getAuthentication("api_token");
api_token.setApiKey("YOUR API KEY");
// Uncomment the following line to set a prefix for the API key, e.g. "Token" (defaults to null)
//api_token.setApiKeyPrefix("Token");

AssessmentsApi apiInstance = new AssessmentsApi();
Assessment assessment = new Assessment(); // Assessment | Assessment to be created
try {
    InlineResponse2004 result = apiInstance.createAssessment(assessment);
    System.out.println(result);
} catch (ApiException e) {
    System.err.println("Exception when calling AssessmentsApi#createAssessment");
    e.printStackTrace();
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **assessment** | [**Assessment**](Assessment.md)| Assessment to be created |

### Return type

[**InlineResponse2004**](InlineResponse2004.md)

### Authorization

[api_token](../README.md#api_token)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

<a name="getAssessment"></a>
# **getAssessment**
> InlineResponse2004 getAssessment(id)

Retrieve an assessment

### Example
```java
// Import classes:
//import org.a15k.client.v1.client.ApiClient;
//import org.a15k.client.v1.client.ApiException;
//import org.a15k.client.v1.client.Configuration;
//import org.a15k.client.v1.client.auth.*;
//import org.a15k.client.v1.client.api.AssessmentsApi;

ApiClient defaultClient = Configuration.getDefaultApiClient();

// Configure API key authorization: api_token
ApiKeyAuth api_token = (ApiKeyAuth) defaultClient.getAuthentication("api_token");
api_token.setApiKey("YOUR API KEY");
// Uncomment the following line to set a prefix for the API key, e.g. "Token" (defaults to null)
//api_token.setApiKeyPrefix("Token");

AssessmentsApi apiInstance = new AssessmentsApi();
Integer id = 56; // Integer | UUID of assessment to fetch
try {
    InlineResponse2004 result = apiInstance.getAssessment(id);
    System.out.println(result);
} catch (ApiException e) {
    System.err.println("Exception when calling AssessmentsApi#getAssessment");
    e.printStackTrace();
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **Integer**| UUID of assessment to fetch |

### Return type

[**InlineResponse2004**](InlineResponse2004.md)

### Authorization

[api_token](../README.md#api_token)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

<a name="searchAssessments"></a>
# **searchAssessments**
> InlineResponse2004 searchAssessments(query, page, perPage)

Search for assessments

### Example
```java
// Import classes:
//import org.a15k.client.v1.client.ApiClient;
//import org.a15k.client.v1.client.ApiException;
//import org.a15k.client.v1.client.Configuration;
//import org.a15k.client.v1.client.auth.*;
//import org.a15k.client.v1.client.api.AssessmentsApi;

ApiClient defaultClient = Configuration.getDefaultApiClient();

// Configure API key authorization: api_token
ApiKeyAuth api_token = (ApiKeyAuth) defaultClient.getAuthentication("api_token");
api_token.setApiKey("YOUR API KEY");
// Uncomment the following line to set a prefix for the API key, e.g. "Token" (defaults to null)
//api_token.setApiKeyPrefix("Token");

AssessmentsApi apiInstance = new AssessmentsApi();
String query = "query_example"; // String | the query string to search for
String page = "page_example"; // String | the page index to return, the first page is 1
String perPage = "perPage_example"; // String | how many assessments should be returned for a page
try {
    InlineResponse2004 result = apiInstance.searchAssessments(query, page, perPage);
    System.out.println(result);
} catch (ApiException e) {
    System.err.println("Exception when calling AssessmentsApi#searchAssessments");
    e.printStackTrace();
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **query** | **String**| the query string to search for |
 **page** | **String**| the page index to return, the first page is 1 | [optional]
 **perPage** | **String**| how many assessments should be returned for a page | [optional]

### Return type

[**InlineResponse2004**](InlineResponse2004.md)

### Authorization

[api_token](../README.md#api_token)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

