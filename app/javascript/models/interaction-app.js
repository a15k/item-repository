import {
  BaseModel, identifiedBy, computed, field, identifier,
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
    return 'When complete, this will contain a script tag that loads easy to use embed JS code';
    // return `<script async type="application/javascript" src="${InteractionApp.api_url}/reporter/${this.id}.js" data-id="${this.id}"></script>`;
  }
}
