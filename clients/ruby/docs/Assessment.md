# A15kClient::Assessment

## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**id** | **String** |  | 
**created_at** | **DateTime** |  | 
**identifier** | **String** | A unique value that can be used to link the assessment back to the contributors copy | [optional] 
**version** | **String** | The version for the assessment, an incrementing number is recommended, but any string value is allowed as long as it‘s unique within the scope of the identifier | 
**visibility** | **String** | If the assessment may be viewed by the public, or only by other a15k members.  Defaults to \&quot;internal\&quot; | 
**preview_html** | **String** | If provided, will be used to generate a preview on the a15k website | [optional] 
**format_id** | **String** | The uuid of a previously registered format | 
**questions** | [**Array&lt;Question&gt;**](Question.md) |  | [optional] 


