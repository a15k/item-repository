import {
  BaseModel, identifiedBy, field, session, identifier, computed,
} from './base';
import { get } from 'lodash';

@identifiedBy('assessments')
export default class Accessment extends BaseModel {

  @identifier id;
  @field format_identifier;
  @field contents;
  @field preview_html;

  @session({ type: 'object' }) metadata;

  @computed get tags() {
    return get(this.metadata, 'tags', []);
  }
}
