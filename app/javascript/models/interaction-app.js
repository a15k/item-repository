import { readonly } from 'core-decorators';
import {
  BaseModel, identifiedBy, computed, field, identifier, action,
} from './base';

@identifiedBy('interactions')
export default class InteractionApp extends BaseModel {

  @identifier id;
  @field api_id;
  @field name;
  @field api_token;
  @field({ type: 'array' }) whitelisted_domains;

}
