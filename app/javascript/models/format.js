import {
  BaseModel, identifiedBy, field, identifier,
} from './base';

@identifiedBy('formats')
export default class Format extends BaseModel {

  @identifier id;
  @field name;
  @field specification;
  // TODO remove default once db is migrated and BE sends this
  @field content_type = 'text/plain';

}
