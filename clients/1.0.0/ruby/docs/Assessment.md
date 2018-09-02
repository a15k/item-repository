# A15kClient::Assessment

## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**id** | **String** | A UUID for this specific assessment version | 
**created_at** | **String** |  | 
**source_identifier** | **String** | A member-controlled identifier that is shared between all versions of this assessment in the member&#39;s assessment repository (the source). | [optional] 
**source_version** | **String** | A member-controlled value identifying this assessment&#39;s version in the member&#39;s assessment repository (the source). | [optional] 
**a15k_identifier** | **String** | An a15k-provided UUID that is shared between all versions of this assessment within the network. | 
**a15k_version** | **Integer** | An a15k-provided number identifying which version this assessment is. | 
**metadata** | [**AssessmentMetadata**](AssessmentMetadata.md) |  | [optional] 
**variants** | [**Array&lt;Variant&gt;**](Variant.md) |  | [optional] 


