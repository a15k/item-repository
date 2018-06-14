# A15kClient::UsersApi

All URIs are relative to *https://null/api/v1*

Method | HTTP request | Description
------------- | ------------- | -------------
[**claim_user**](UsersApi.md#claim_user) | **POST** /users/add | add a newly created user account to a membership
[**delete_user**](UsersApi.md#delete_user) | **DELETE** /users/{id} | remove a user from membership
[**get_users**](UsersApi.md#get_users) | **GET** /users | Get all users for the membership
[**update_user**](UsersApi.md#update_user) | **PUT** /users/{id} | alter a user


# **claim_user**
> InlineResponse2001 claim_user(email, role)

add a newly created user account to a membership

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

api_instance = A15kClient::UsersApi.new

email = "email_example" # String | email of user to join to membership

role = A15kClient::null.new #  | role to grant to user


begin
  #add a newly created user account to a membership
  result = api_instance.claim_user(email, role)
  p result
rescue A15kClient::ApiError => e
  puts "Exception when calling UsersApi->claim_user: #{e}"
end
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **email** | **String**| email of user to join to membership | 
 **role** | [****](.md)| role to grant to user | 

### Return type

[**InlineResponse2001**](InlineResponse2001.md)

### Authorization

[api_token](../README.md#api_token)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json



# **delete_user**
> InlineResponse2001 delete_user

remove a user from membership

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

api_instance = A15kClient::UsersApi.new

begin
  #remove a user from membership
  result = api_instance.delete_user
  p result
rescue A15kClient::ApiError => e
  puts "Exception when calling UsersApi->delete_user: #{e}"
end
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



# **get_users**
> InlineResponse200 get_users

Get all users for the membership

List all users

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

api_instance = A15kClient::UsersApi.new

begin
  #Get all users for the membership
  result = api_instance.get_users
  p result
rescue A15kClient::ApiError => e
  puts "Exception when calling UsersApi->get_users: #{e}"
end
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



# **update_user**
> InlineResponse2001 update_user(role)

alter a user

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

api_instance = A15kClient::UsersApi.new

role = A15kClient::null.new #  | role to grant to user


begin
  #alter a user
  result = api_instance.update_user(role)
  p result
rescue A15kClient::ApiError => e
  puts "Exception when calling UsersApi->update_user: #{e}"
end
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



