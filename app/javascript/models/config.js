import { action, observable } from 'mobx';
import { read_csrf } from '../helpers/dom';

export class Config {

  @observable token;
  @observable csrf_token;
  @observable member_name;
  @observable accounts_url;

  @action.bound bootstrap(data) {
    this.jwt = data.token;
    this.openstax_accounts_url = data.openstax_accounts_url;
    this.csrf_token = read_csrf();
    this.member_name = data.member_name;
  }

}

const config = new Config;
export default config;
