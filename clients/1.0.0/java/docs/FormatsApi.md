# FormatsApi

All URIs are relative to *https://null/api/v1*

Method | HTTP request | Description
------------- | ------------- | -------------
[**createFormat**](FormatsApi.md#createFormat) | **POST** /formats | create  a format
[**getFormats**](FormatsApi.md#getFormats) | **GET** /formats | Get all formats


<a name="createFormat"></a>
# **createFormat**
> InlineResponse2003 createFormat(format)

create  a format

### Example
```java
// Import classes:
//import org.a15k.client.v1.client.ApiClient;
//import org.a15k.client.v1.client.ApiException;
//import org.a15k.client.v1.client.Configuration;
//import org.a15k.client.v1.client.auth.*;
//import org.a15k.client.v1.client.api.FormatsApi;

ApiClient defaultClient = Configuration.getDefaultApiClient();

// Configure API key authorization: api_token
ApiKeyAuth api_token = (ApiKeyAuth) defaultClient.getAuthentication("api_token");
api_token.setApiKey("YOUR API KEY");
// Uncomment the following line to set a prefix for the API key, e.g. "Token" (defaults to null)
//api_token.setApiKeyPrefix("Token");

FormatsApi apiInstance = new FormatsApi();
Format format = new Format(); // Format | Format to be created
try {
    InlineResponse2003 result = apiInstance.createFormat(format);
    System.out.println(result);
} catch (ApiException e) {
    System.err.println("Exception when calling FormatsApi#createFormat");
    e.printStackTrace();
}
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

<a name="getFormats"></a>
# **getFormats**
> InlineResponse2002 getFormats()

Get all formats

List all known formats

### Example
```java
// Import classes:
//import org.a15k.client.v1.client.ApiClient;
//import org.a15k.client.v1.client.ApiException;
//import org.a15k.client.v1.client.Configuration;
//import org.a15k.client.v1.client.auth.*;
//import org.a15k.client.v1.client.api.FormatsApi;

ApiClient defaultClient = Configuration.getDefaultApiClient();

// Configure API key authorization: api_token
ApiKeyAuth api_token = (ApiKeyAuth) defaultClient.getAuthentication("api_token");
api_token.setApiKey("YOUR API KEY");
// Uncomment the following line to set a prefix for the API key, e.g. "Token" (defaults to null)
//api_token.setApiKeyPrefix("Token");

FormatsApi apiInstance = new FormatsApi();
try {
    InlineResponse2002 result = apiInstance.getFormats();
    System.out.println(result);
} catch (ApiException e) {
    System.err.println("Exception when calling FormatsApi#getFormats");
    e.printStackTrace();
}
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

