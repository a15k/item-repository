import {
  BaseModel, identifiedBy, field, identifier,
} from './base';
// not currently exposed
// import Solution from './solution';

@identifiedBy('variant')
export default class Variant extends BaseModel {

  @identifier id;
  @field source_identifier;
  @field format_id;
  @field({ type: 'object' }) content;
  @field preview_html;
  // hidden since we're not currently exposing solutions
  // @hasMany({ model: Solution }) solutions;

}
