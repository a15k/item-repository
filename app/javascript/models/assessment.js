import {
  BaseModel, identifiedBy, field, session, identifier, computed, hasMany, belongsTo,
} from './base';
import { first, get } from 'lodash';
import Variant from './variant';
import Member from './member';

@identifiedBy('assessments')
export default class Assessment extends BaseModel {

  @identifier id;
  @field a15k_identifier;
  @field preview_html;
  @field a15k_version;

  @belongsTo({ model: Member }) member;
  @hasMany({ model: Variant }) variants;

  @session({ type: 'object' }) metadata;

  @computed get tags() {
    return get(this.metadata, 'tags', []);
  }

  @computed get format_id() {
    return get(first(this.variants), 'format_id');
  }

}
