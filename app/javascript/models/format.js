import {
  BaseModel, identifiedBy, field, identifier, computed,
} from './base';
import FormatSpecification from './format/specification';

@identifiedBy('formats')
export default class Format extends BaseModel {

  @identifier id;
  @field identifier;
  @field name;
  @field specification;
  // TODO remove default once db is migrated and BE sends this
  @field content_type = 'text/plain';

  @computed get specification_document() {
    return FormatSpecification.generate(this);
  }
}
