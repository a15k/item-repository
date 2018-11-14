# v1client

## Requirements

Building the API client library requires [Maven](https://maven.apache.org/) to be installed.

## Installation

To install the API client library to your local Maven repository, simply execute:

```shell
mvn install
```

To deploy it to a remote Maven repository instead, configure the settings of the repository and execute:

```shell
mvn deploy
```

Refer to the [official documentation](https://maven.apache.org/plugins/maven-deploy-plugin/usage.html) for more information.

### Maven users

Add this dependency to your project's POM:

```xml
<dependency>
    <groupId>org.a15k.client.v1</groupId>
    <artifactId>v1client</artifactId>
    <version>1.0.0</version>
    <scope>compile</scope>
</dependency>
```

### Gradle users

Add this dependency to your project's build file:

```groovy
compile "org.a15k.client.v1:v1client:1.0.0"
```

### Others

At first generate the JAR by executing:

    mvn package

Then manually install the following JARs:

* target/v1client-1.0.0.jar
* target/lib/*.jar

## Getting Started

Please follow the [installation](#installation) instruction and execute the following Java code:

```java

import org.a15k.client.v1.client.*;
import org.a15k.client.v1.client.auth.*;
import org.a15k.client.v1.client.model.*;
import org.a15k.client.v1.client.api.AccessTokensApi;

import java.io.File;
import java.util.*;

public class AccessTokensApiExample {

    public static void main(String[] args) {
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
    }
}

```

## Documentation for API Endpoints

All URIs are relative to *https://null/api/v1*

Class | Method | HTTP request | Description
------------ | ------------- | ------------- | -------------
*AccessTokensApi* | [**createToken**](docs/AccessTokensApi.md#createToken) | **POST** /access_tokens | create  a token
*AccessTokensApi* | [**deleteToken**](docs/AccessTokensApi.md#deleteToken) | **DELETE** /access_tokens/{id} | delete  a token
*AccessTokensApi* | [**getTokens**](docs/AccessTokensApi.md#getTokens) | **GET** /access_tokens | Get all tokens
*AccessTokensApi* | [**updateToken**](docs/AccessTokensApi.md#updateToken) | **PUT** /access_tokens/{id} | update  a token
*AssessmentsApi* | [**createAssessment**](docs/AssessmentsApi.md#createAssessment) | **POST** /assessments | create an assessment
*AssessmentsApi* | [**getAssessment**](docs/AssessmentsApi.md#getAssessment) | **GET** /assessments/{id} | Retrieve an assessment
*AssessmentsApi* | [**searchAssessments**](docs/AssessmentsApi.md#searchAssessments) | **GET** /assessments | Search for assessments
*FormatsApi* | [**createFormat**](docs/FormatsApi.md#createFormat) | **POST** /formats | create  a format
*FormatsApi* | [**getFormats**](docs/FormatsApi.md#getFormats) | **GET** /formats | Get all formats
*UsersApi* | [**claimUser**](docs/UsersApi.md#claimUser) | **POST** /users/add | add a newly created user account to a member
*UsersApi* | [**deleteUser**](docs/UsersApi.md#deleteUser) | **DELETE** /users/{id} | remove a user from member
*UsersApi* | [**getUsers**](docs/UsersApi.md#getUsers) | **GET** /users | Get all users for the member
*UsersApi* | [**updateUser**](docs/UsersApi.md#updateUser) | **PUT** /users/{id} | alter a user


## Documentation for Models

 - [AccessToken](docs/AccessToken.md)
 - [Assessment](docs/Assessment.md)
 - [AssessmentMetadata](docs/AssessmentMetadata.md)
 - [Error](docs/Error.md)
 - [Format](docs/Format.md)
 - [InlineResponse200](docs/InlineResponse200.md)
 - [InlineResponse2001](docs/InlineResponse2001.md)
 - [InlineResponse2002](docs/InlineResponse2002.md)
 - [InlineResponse2003](docs/InlineResponse2003.md)
 - [InlineResponse2004](docs/InlineResponse2004.md)
 - [InlineResponse2005](docs/InlineResponse2005.md)
 - [InlineResponse2006](docs/InlineResponse2006.md)
 - [User](docs/User.md)
 - [Variant](docs/Variant.md)


## Documentation for Authorization

Authentication schemes defined for the API:
### api_token

- **Type**: API key
- **API key parameter name**: Authorization
- **Location**: HTTP header


## Recommendation

It's recommended to create an instance of `ApiClient` per thread in a multithreaded environment to avoid any potential issues.

## Author



