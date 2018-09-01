# A15kClient::Assessment

## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**id** | **String** | A unique value that can be used to link the assessment back to the contributors copy | 
**created_at** | **String** |  | 
**identifier** | **String** | An unique contributed-provided identifier that can be used to link the assessment back to the contributor&#39;s original version | [optional] 
**version** | **String** | The version for the assessment, an incrementing number is recommended, but any string value is allowed as long as it‘s unique within the scope of the identifier | 
**preview_html** | **String** | If provided, will be used to generate a preview on the a15k website | [optional] 
**metadata** | [**AssessmentMetadata**](AssessmentMetadata.md) |  | [optional] 
**variants** | [**Array&lt;Variant&gt;**](Variant.md) |  | [optional] 


