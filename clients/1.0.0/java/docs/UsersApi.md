# UsersApi

All URIs are relative to *https://null/api/v1*

Method | HTTP request | Description
------------- | ------------- | -------------
[**claimUser**](UsersApi.md#claimUser) | **POST** /users/add | add a newly created user account to a member
[**deleteUser**](UsersApi.md#deleteUser) | **DELETE** /users/{id} | remove a user from member
[**getUsers**](UsersApi.md#getUsers) | **GET** /users | Get all users for the member
[**updateUser**](UsersApi.md#updateUser) | **PUT** /users/{id} | alter a user


<a name="claimUser"></a>
# **claimUser**
> InlineResponse2001 claimUser(email, role)

add a newly created user account to a member

### Example
```java
// Import classes:
//import org.a15k.client.v1.client.ApiClient;
//import org.a15k.client.v1.client.ApiException;
//import org.a15k.client.v1.client.Configuration;
//import org.a15k.client.v1.client.auth.*;
//import org.a15k.client.v1.client.api.UsersApi;

ApiClient defaultClient = Configuration.getDefaultApiClient();

// Configure API key authorization: api_token
ApiKeyAuth api_token = (ApiKeyAuth) defaultClient.getAuthentication("api_token");
api_token.setApiKey("YOUR API KEY");
// Uncomment the following line to set a prefix for the API key, e.g. "Token" (defaults to null)
//api_token.setApiKeyPrefix("Token");

UsersApi apiInstance = new UsersApi();
String email = "email_example"; // String | email of user to join to member
 role = new null(); //  | role to grant to user
try {
    InlineResponse2001 result = apiInstance.claimUser(email, role);
    System.out.println(result);
} catch (ApiException e) {
    System.err.println("Exception when calling UsersApi#claimUser");
    e.printStackTrace();
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **email** | **String**| email of user to join to member |
 **role** | [****](.md)| role to grant to user |

### Return type

[**InlineResponse2001**](InlineResponse2001.md)

### Authorization

[api_token](../README.md#api_token)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

<a name="deleteUser"></a>
# **deleteUser**
> InlineResponse2001 deleteUser()

remove a user from member

### Example
```java
// Import classes:
//import org.a15k.client.v1.client.ApiClient;
//import org.a15k.client.v1.client.ApiException;
//import org.a15k.client.v1.client.Configuration;
//import org.a15k.client.v1.client.auth.*;
//import org.a15k.client.v1.client.api.UsersApi;

ApiClient defaultClient = Configuration.getDefaultApiClient();

// Configure API key authorization: api_token
ApiKeyAuth api_token = (ApiKeyAuth) defaultClient.getAuthentication("api_token");
api_token.setApiKey("YOUR API KEY");
// Uncomment the following line to set a prefix for the API key, e.g. "Token" (defaults to null)
//api_token.setApiKeyPrefix("Token");

UsersApi apiInstance = new UsersApi();
try {
    InlineResponse2001 result = apiInstance.deleteUser();
    System.out.println(result);
} catch (ApiException e) {
    System.err.println("Exception when calling UsersApi#deleteUser");
    e.printStackTrace();
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**InlineResponse2001**](InlineResponse2001.md)

### Authorization

[api_token](../README.md#api_token)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

<a name="getUsers"></a>
# **getUsers**
> InlineResponse200 getUsers()

Get all users for the member

### Example
```java
// Import classes:
//import org.a15k.client.v1.client.ApiClient;
//import org.a15k.client.v1.client.ApiException;
//import org.a15k.client.v1.client.Configuration;
//import org.a15k.client.v1.client.auth.*;
//import org.a15k.client.v1.client.api.UsersApi;

ApiClient defaultClient = Configuration.getDefaultApiClient();

// Configure API key authorization: api_token
ApiKeyAuth api_token = (ApiKeyAuth) defaultClient.getAuthentication("api_token");
api_token.setApiKey("YOUR API KEY");
// Uncomment the following line to set a prefix for the API key, e.g. "Token" (defaults to null)
//api_token.setApiKeyPrefix("Token");

UsersApi apiInstance = new UsersApi();
try {
    InlineResponse200 result = apiInstance.getUsers();
    System.out.println(result);
} catch (ApiException e) {
    System.err.println("Exception when calling UsersApi#getUsers");
    e.printStackTrace();
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**InlineResponse200**](InlineResponse200.md)

### Authorization

[api_token](../README.md#api_token)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

<a name="updateUser"></a>
# **updateUser**
> InlineResponse2001 updateUser(role)

alter a user

### Example
```java
// Import classes:
//import org.a15k.client.v1.client.ApiClient;
//import org.a15k.client.v1.client.ApiException;
//import org.a15k.client.v1.client.Configuration;
//import org.a15k.client.v1.client.auth.*;
//import org.a15k.client.v1.client.api.UsersApi;

ApiClient defaultClient = Configuration.getDefaultApiClient();

// Configure API key authorization: api_token
ApiKeyAuth api_token = (ApiKeyAuth) defaultClient.getAuthentication("api_token");
api_token.setApiKey("YOUR API KEY");
// Uncomment the following line to set a prefix for the API key, e.g. "Token" (defaults to null)
//api_token.setApiKeyPrefix("Token");

UsersApi apiInstance = new UsersApi();
 role = new null(); //  | role to grant to user
try {
    InlineResponse2001 result = apiInstance.updateUser(role);
    System.out.println(result);
} catch (ApiException e) {
    System.err.println("Exception when calling UsersApi#updateUser");
    e.printStackTrace();
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **role** | [****](.md)| role to grant to user |

### Return type

[**InlineResponse2001**](InlineResponse2001.md)

### Authorization

[api_token](../README.md#api_token)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

