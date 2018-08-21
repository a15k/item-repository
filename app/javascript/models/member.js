import {
  BaseModel, identifiedBy, field, identifier,
} from './base';

@identifiedBy('member')
export default class Member extends BaseModel {

  @identifier id;
  @field name;

}
