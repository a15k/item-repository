# A15kClient::AssessmentInput

## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**identifier** | **String** | A unique identifier for the assessment, uuid is recommended but not required | [optional] 
**format_id** | **String** | The uuid of a previously registered format | 
**version** | **String** | The version for the assessment, an incrementing number is recommended, but any string value is allowed as long as it‘s unique within the scope of the identifier | [optional] 
**content** | **String** | Content the applies to all questions and solutions.  The formatting the the content is indicated by the assessment&#39;s linked format | [optional] 
**visibility** | **String** | If the assessment may be viewed by the public, or only by other a15k members.  Defaults to \&quot;internal\&quot; | [optional] 
**questions** | [**Array&lt;AssessmentInputQuestions&gt;**](AssessmentInputQuestions.md) |  | [optional] 


