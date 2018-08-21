import { observable, action } from 'mobx';
import { isArray } from 'lodash';
import lazyGetter from '../helpers/lazy-getter.js';
import ModelApi from './api';
export default class ModelCollection {

  @lazyGetter api = new ModelApi(this, this.model.baseUrl || this.model.identifiedBy);

  @observable map = observable.map();
  @observable errors;

  constructor(model, baseUrl) {
    this.model = model;
    this.baseUrl = baseUrl;
  }

  fetch({ id } = {}) {
    let url = this.api.baseUrl;
    if (id) { url += `/${id}`; }
    return this.api.request({ model: this, url });
  }

  objectToModel(dataOrModel) {
    return (dataOrModel instanceof this.model) ? dataOrModel : new this.model(dataOrModel);
  }

  get array() {
    return Array.from(this.map.values());
  }

  delete(key){ this.map.delete(key); }
  get(key) { return this.map.get(key); }
  set(key, value) {
    return this.map.set(key, this.objectToModel(value));
  }

  @action fromJSON(data) {
    if (isArray(data)) {
      return data.map(obj => {
        this.set(obj.id, obj);
        return this.get(obj.id);
      });
    } else {
      this.set(data.id, data);
      return this.get(data.id);
    }
  }

  @action create(dataOrModel) {
    const req = this.api.create(this.objectToModel(dataOrModel));
    if (req && req.then) {
      return req.then((json) => {
        return this.fromJSON(json);
      });
    }
    return req;
  }

  @action destroy(dataOrModel) {
    const req = this.api.destroy(dataOrModel);
    if (req && req.then) {
      return req.then((json) => {
        this.delete(dataOrModel.id);
        return json;
      });
    }
    return req;
  }
}
