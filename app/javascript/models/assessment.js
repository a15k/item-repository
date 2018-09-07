import {
  BaseModel, identifiedBy, observable, field, session,
  identifier, computed, hasMany, belongsTo,
} from './base';
import { first, get } from 'lodash';
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

  @observable renderedHeight = 300;

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
