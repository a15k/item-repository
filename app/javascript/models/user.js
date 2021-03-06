import { isNil, filter } from 'lodash';
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
  @field member_id;
  @field username;

  @computed get isLoggedIn() {
    return Boolean(this.id) && currentUser === this;
  }

  @computed get isMember() {
    return !isNil(this.member_id);
  }

  @action.bound bootstrap(data) {
    Config.bootstrap(data);
    this.update(data.user);
  }

  @action togglePowerUser() {
    this.role = this.role === 'power_user' ? 'standard_user' : 'power_user';
  }

  @computed get isPowerUser() {
    return Boolean(
      this.isMember && this.role === 'power_user'
    );
  }

  set isPowerUser(pu) {
    this.role = pu ? 'power_user' : 'standard_user';
  }

  @action.bound logout() {
    // kinda nasty to rely on the DOM from a model
    // but the logout call needs to be a real form post
    document.getElementById('logout-form').submit();
  }

}

User.collection.invite = function(email, role = 'standard_user') {
  const user = new User({ role });
  return user.api.request({
    model: this,
    body: JSON.stringify({ role, email }),
    method: 'post',
    url: `${user.api.baseUrl}/add`,
  });
};

User.collection.powerUsers = function() {
  return filter(this.array, { role: 'power_user' });
};

currentUser = new User;
export default currentUser;
