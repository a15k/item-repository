import { readonly } from 'core-decorators';
import {
  BaseModel, identifiedBy, computed, field, identifier, action,
} from './base';
import Config from './config';

let currentUser = null;

@identifiedBy('user')
export class User extends BaseModel {

  static baseUrl = 'users'

  @identifier id;
  @field name;
  @field role;
  @field username;

  @computed get isLoggedIn() {
    return Boolean(this.id) && currentUser === this;
  }

  @action.bound bootstrap(data) {
    Config.bootstrap(data);
    this.update(data.user);
  }

  @computed get isPowerUser() {
    return this.role === 'power_user';
  }

  set isPowerUser(pu) {
    this.role = pu ? 'power_user' : 'standard_user';
  }

}

User.collection.invite = function(username, role = 'standard_user') {
  const user = new User({ role });
  return user.api.request({
    model: this,
    body: JSON.stringify({ role, username }),
    method: 'post',
    url: `${user.api.baseUrl}/add`,
  });
};

currentUser = new User;
export default currentUser;
