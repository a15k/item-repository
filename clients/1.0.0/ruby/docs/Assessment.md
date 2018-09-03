# A15kClient::Assessment

## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**id** | **String** | A UUID for this specific assessment version | 
**created_at** | **String** |  | 
**source_identifier** | **String** | A member-controlled identifier that is shared between all versions of this assessment in the member&#39;s assessment repository (the source).  If contributing a new version of a previous contribution, provide the source_identifier you provided for other versions or the a15k_identifier from those versions.  | [optional] 
**source_version** | **String** | A member-controlled value identifying this assessment&#39;s version in the member&#39;s assessment repository (the source). | [optional] 
**a15k_identifier** | **String** | An a15k-provided UUID that is shared between all versions of this assessment within the network. If contributing a new version of a previous contribution, provide this a15k_identifier or the source_identifier you provided for the other versions.  | 
**a15k_version** | **Integer** | An a15k-provided number identifying which version this assessment is. | 
**metadata** | [**AssessmentMetadata**](AssessmentMetadata.md) |  | [optional] 
**variants** | [**Array&lt;Variant&gt;**](Variant.md) |  | [optional] 


