import {
  BaseModel, identifiedBy, field, identifier,
} from './base';

@identifiedBy('access-token')
export default class AccessToken extends BaseModel {

  static baseUrl = 'access_tokens'

  @identifier id;
  @field name = '';
  @field token;

}
