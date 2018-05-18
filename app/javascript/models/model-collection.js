import { observable, computed, action } from 'mobx';
import { first, isArray } from 'lodash';
import lazyGetter from '../helpers/lazy-getter.js';
import ModelApi from './api';

const Map = observable.map().constructor;

export default class ModelCollection extends Map {

  @lazyGetter api = new ModelApi(this, this.model.baseUrl || this.model.identifiedBy);

  constructor(model, baseUrl) {
    super();
    this.model = model;
    this.baseUrl = baseUrl;
    this.intercept(this.onModelChange);
  }

  objectToModel(dataOrModel) {
    return (dataOrModel instanceof this.model) ? dataOrModel : new this.model(dataOrModel);
  }

  @action.bound onModelChange(change) {
    change.newValue = this.objectToModel(change.newValue);
    return change;
  }

  get array() {
    return Array.from(super.values());
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
    return this.api.create(this.objectToModel(dataOrModel)).then((json) => {
      return this.fromJSON(json);
    });
  }

  @action destroy(dataOrModel) {
    return this.api.destroy(dataOrModel).then((json) => {
      this.delete(dataOrModel.id);
      return json;
    });

  }
}
