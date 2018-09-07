import {
  BaseModel, identifiedBy, field, session, identifier, computed, hasMany, belongsTo,
} from './base';
import { first, get, map } from 'lodash';
import Variant from './variant';
import Member from './member';
import AssessmentPreview from './assessment/preview';

@identifiedBy('assessments')
export default class Assessment extends BaseModel {

  @identifier id;
  @field a15k_identifier;

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

  @computed get preview_html() {
    return this.variants[0].preview_html;
  }

  @computed get preview_document() {
    return AssessmentPreview.generate(this);
  }

}
