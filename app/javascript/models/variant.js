import {
  BaseModel, identifiedBy, field, identifier, hasMany,
} from './base';
import Solution from './solution';

@identifiedBy('variant')
export default class Variant extends BaseModel {

  @identifier id;
  @field format_id;
  @field({ type: 'object' }) content;
  @field preview_html;
  @hasMany({ model: Solution }) solutions;

}
