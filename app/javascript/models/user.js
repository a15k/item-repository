import { readonly } from 'core-decorators';
import {
  BaseModel, identifiedBy, computed, field, identifier, action,
} from './base';
import Config from './config';

@identifiedBy('user')
export class User extends BaseModel {

  @identifier id;
  @field name;

  @computed get isLoggedIn() {
    return Boolean(this.id);
  }

  @action.bound bootstrap(data) {
    Config.bootstrap(data);
    this.update(data.user);
  }

}

const currentUser = new User;
export default currentUser;
