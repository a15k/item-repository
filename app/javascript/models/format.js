import {
  BaseModel, identifiedBy, field, identifier,
} from './base';

@identifiedBy('formats')
export default class Format extends BaseModel {

  @identifier id;
  @field name;
  @field specification;

}
