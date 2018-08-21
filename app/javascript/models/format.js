import {
  BaseModel, identifiedBy, field, session, identifier, computed,
} from './base';
import { get } from 'lodash';

@identifiedBy('formats')
export default class Format extends BaseModel {

  @identifier id;
  @field name;
  @field specification;

}
