import {
  BaseModel, identifiedBy, computed, field, observable, hasMany, identifier, action,
} from './base';

@identifiedBy('assessment')
export default class Accessment extends BaseModel {

  @identifier id;
  @field format_identifier;
  @field contents;

  // @action fetch() {
  //   this.api.
  // }

}
