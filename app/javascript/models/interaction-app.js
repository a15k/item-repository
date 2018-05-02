import { readonly } from 'core-decorators';
import {
  BaseModel, identifiedBy, computed, field, identifier, action,
} from './base';

@identifiedBy('interactions')
export default class InteractionApp extends BaseModel {

  static api_url;

  @identifier id;
  @field api_id;
  @field name;
  @field api_token;
  @field({ type: 'array' }) whitelisted_domains;

  @computed get embed_html() {
    return `<script async type="application/javascript" src="${InteractionApp.api_url}/reporter/${this.id}.js" data-id="${this.id}"></script>`;
  }
}
