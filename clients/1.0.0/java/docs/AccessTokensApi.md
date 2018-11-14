# AccessTokensApi

All URIs are relative to *https://null/api/v1*

Method | HTTP request | Description
------------- | ------------- | -------------
[**createToken**](AccessTokensApi.md#createToken) | **POST** /access_tokens | create  a token
[**deleteToken**](AccessTokensApi.md#deleteToken) | **DELETE** /access_tokens/{id} | delete  a token
[**getTokens**](AccessTokensApi.md#getTokens) | **GET** /access_tokens | Get all tokens
[**updateToken**](AccessTokensApi.md#updateToken) | **PUT** /access_tokens/{id} | update  a token


<a name="createToken"></a>
# **createToken**
> InlineResponse2006 createToken(token)

create  a token

### Example
```java
// Import classes:
//import org.a15k.client.v1.client.ApiClient;
//import org.a15k.client.v1.client.ApiException;
//import org.a15k.client.v1.client.Configuration;
//import org.a15k.client.v1.client.auth.*;
//import org.a15k.client.v1.client.api.AccessTokensApi;

ApiClient defaultClient = Configuration.getDefaultApiClient();

// Configure API key authorization: api_token
ApiKeyAuth api_token = (ApiKeyAuth) defaultClient.getAuthentication("api_token");
api_token.setApiKey("YOUR API KEY");
// Uncomment the following line to set a prefix for the API key, e.g. "Token" (defaults to null)
//api_token.setApiKeyPrefix("Token");

AccessTokensApi apiInstance = new AccessTokensApi();
AccessToken token = new AccessToken(); // AccessToken | Access Token to be created
try {
    InlineResponse2006 result = apiInstance.createToken(token);
    System.out.println(result);
} catch (ApiException e) {
    System.err.println("Exception when calling AccessTokensApi#createToken");
    e.printStackTrace();
}
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

<a name="deleteToken"></a>
# **deleteToken**
> InlineResponse2006 deleteToken()

delete  a token

### Example
```java
// Import classes:
//import org.a15k.client.v1.client.ApiClient;
//import org.a15k.client.v1.client.ApiException;
//import org.a15k.client.v1.client.Configuration;
//import org.a15k.client.v1.client.auth.*;
//import org.a15k.client.v1.client.api.AccessTokensApi;

ApiClient defaultClient = Configuration.getDefaultApiClient();

// Configure API key authorization: api_token
ApiKeyAuth api_token = (ApiKeyAuth) defaultClient.getAuthentication("api_token");
api_token.setApiKey("YOUR API KEY");
// Uncomment the following line to set a prefix for the API key, e.g. "Token" (defaults to null)
//api_token.setApiKeyPrefix("Token");

AccessTokensApi apiInstance = new AccessTokensApi();
try {
    InlineResponse2006 result = apiInstance.deleteToken();
    System.out.println(result);
} catch (ApiException e) {
    System.err.println("Exception when calling AccessTokensApi#deleteToken");
    e.printStackTrace();
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**InlineResponse2006**](InlineResponse2006.md)

### Authorization

[api_token](../README.md#api_token)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

<a name="getTokens"></a>
# **getTokens**
> InlineResponse2005 getTokens()

Get all tokens

List all known tokens

### Example
```java
// Import classes:
//import org.a15k.client.v1.client.ApiClient;
//import org.a15k.client.v1.client.ApiException;
//import org.a15k.client.v1.client.Configuration;
//import org.a15k.client.v1.client.auth.*;
//import org.a15k.client.v1.client.api.AccessTokensApi;

ApiClient defaultClient = Configuration.getDefaultApiClient();

// Configure API key authorization: api_token
ApiKeyAuth api_token = (ApiKeyAuth) defaultClient.getAuthentication("api_token");
api_token.setApiKey("YOUR API KEY");
// Uncomment the following line to set a prefix for the API key, e.g. "Token" (defaults to null)
//api_token.setApiKeyPrefix("Token");

AccessTokensApi apiInstance = new AccessTokensApi();
try {
    InlineResponse2005 result = apiInstance.getTokens();
    System.out.println(result);
} catch (ApiException e) {
    System.err.println("Exception when calling AccessTokensApi#getTokens");
    e.printStackTrace();
}
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

<a name="updateToken"></a>
# **updateToken**
> InlineResponse2006 updateToken(token)

update  a token

### Example
```java
// Import classes:
//import org.a15k.client.v1.client.ApiClient;
//import org.a15k.client.v1.client.ApiException;
//import org.a15k.client.v1.client.Configuration;
//import org.a15k.client.v1.client.auth.*;
//import org.a15k.client.v1.client.api.AccessTokensApi;

ApiClient defaultClient = Configuration.getDefaultApiClient();

// Configure API key authorization: api_token
ApiKeyAuth api_token = (ApiKeyAuth) defaultClient.getAuthentication("api_token");
api_token.setApiKey("YOUR API KEY");
// Uncomment the following line to set a prefix for the API key, e.g. "Token" (defaults to null)
//api_token.setApiKeyPrefix("Token");

AccessTokensApi apiInstance = new AccessTokensApi();
AccessToken token = new AccessToken(); // AccessToken | Access Token to be updated
try {
    InlineResponse2006 result = apiInstance.updateToken(token);
    System.out.println(result);
} catch (ApiException e) {
    System.err.println("Exception when calling AccessTokensApi#updateToken");
    e.printStackTrace();
}
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

