import {
  BaseModel, identifiedBy, field, session, identifier, computed, hasMany, belongsTo,
} from './base';
import { first, get } from 'lodash';
import Question from './question';
import Member from './member';

@identifiedBy('assessments')
export default class Accessment extends BaseModel {

  @identifier id;
  @field format_identifier;
  @field preview_html;
  @field version;

  @belongsTo({ model: Member }) member;
  @hasMany({ model: Question }) questions;

  @session({ type: 'object' }) metadata;

  @computed get tags() {
    return get(this.metadata, 'tags', []);
  }

  @computed get format_id() {
    return get(first(this.questions), 'format_id');
  }

}
