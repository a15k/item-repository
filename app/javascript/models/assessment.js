import {
  BaseModel, identifiedBy, field, identifier,
} from './base';

@identifiedBy('assessments')
export default class Accessment extends BaseModel {

  @identifier id;
  @field format_identifier;
  @field contents;
  @field preview_html;

}
