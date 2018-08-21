import {
  BaseModel, identifiedBy, field, identifier,
} from './base';

@identifiedBy('solution')
export default class Solution extends BaseModel {

  @identifier id;
  @field({ type: 'object' }) content;

}
