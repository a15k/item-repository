import { computed, observable } from 'mobx';
import lazyGetter from '../helpers/lazy-getter.js';
import ModelApi from './api';
import ModelCollection from './model-collection';

export class BaseModel {

  static get collection() {
    if (!this.$collection) { this.$collection = new ModelCollection(this); }
    return this.$collection;
  }

  @lazyGetter api = new ModelApi(this);
  @observable errors;

  static fetch({ id }) {
    const model = new this({ id });
    let url = model.api.baseUrl;
    if (id) { url += `/${id}`; }
    return model.api.request({ model, url });
  }

  constructor(attrs) {
    if (attrs) this.fromJSON(attrs);
  }

  fromJSON(json) {
    if (json.attributes) {
      if(json.id) { this.id = json.id; }
      this.update(json.attributes);
    } else {
      this.update(json);
    }
  }

  save() {
    return this.api.save(this);
  }

  @computed get isNew() {
    return !this.id;
  }
}

// export decorators so they can be easily imported into model classes
export {
  identifiedBy, identifier, hasMany, belongsTo, field, session,
} from 'mobx-decorated-models';

export {
  computed,
  observable,
  action,
} from 'mobx';
