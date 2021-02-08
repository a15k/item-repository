/*
 * Assessment Network API
 * > Stores content for the Assessment Network  API Version is specified in the URL path as `api/<version>/resource` Version will default to the latest if it's ommited  All endpoints require an API key to be passed in the request header. API keys can be obtained by members at www.a15k.org. 
 *
 * OpenAPI spec version: 1.0.0
 * 
 *
 * NOTE: This class is auto generated by the swagger code generator program.
 * https://github.com/swagger-api/swagger-codegen.git
 * Do not edit the class manually.
 */


package org.a15k.client.v1.client.api;

import org.a15k.client.v1.client.ApiException;
import org.a15k.client.v1.client.model.AccessToken;
import org.a15k.client.v1.client.model.Error;
import org.a15k.client.v1.client.model.InlineResponse2005;
import org.a15k.client.v1.client.model.InlineResponse2006;
import org.junit.Test;
import org.junit.Ignore;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * API tests for AccessTokensApi
 */
@Ignore
public class AccessTokensApiTest {

    private final AccessTokensApi api = new AccessTokensApi();

    
    /**
     * create  a token
     *
     * 
     *
     * @throws ApiException
     *          if the Api call fails
     */
    @Test
    public void createTokenTest() throws ApiException {
        AccessToken token = null;
        InlineResponse2006 response = api.createToken(token);

        // TODO: test validations
    }
    
    /**
     * delete  a token
     *
     * 
     *
     * @throws ApiException
     *          if the Api call fails
     */
    @Test
    public void deleteTokenTest() throws ApiException {
        InlineResponse2006 response = api.deleteToken();

        // TODO: test validations
    }
    
    /**
     * Get all tokens
     *
     * List all known tokens
     *
     * @throws ApiException
     *          if the Api call fails
     */
    @Test
    public void getTokensTest() throws ApiException {
        InlineResponse2005 response = api.getTokens();

        // TODO: test validations
    }
    
    /**
     * update  a token
     *
     * 
     *
     * @throws ApiException
     *          if the Api call fails
     */
    @Test
    public void updateTokenTest() throws ApiException {
        AccessToken token = null;
        InlineResponse2006 response = api.updateToken(token);

        // TODO: test validations
    }
    
}