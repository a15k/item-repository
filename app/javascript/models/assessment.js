import {
  BaseModel, identifiedBy, field, session, identifier, computed, hasMany,
} from './base';
import { first, get } from 'lodash';
import Question from './question';

@identifiedBy('assessments')
export default class Accessment extends BaseModel {

  @identifier id;
  @field format_identifier;
  @field contents;
  @field preview_html;

  @hasMany({ model: Question }) questions;

  @session({ type: 'object' }) metadata;

  @computed get tags() {
    return get(this.metadata, 'tags', []);
  }

  @computed get format_id() {
    return get(first(this.questions), 'format_id');
  }

}
