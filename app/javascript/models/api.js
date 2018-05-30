import { observable, computed, action } from 'mobx';
import { readonly } from 'core-decorators';
import Config from './config';

export default class ModelApi {

  @readonly requestsInProgress = observable.map();

  @readonly requestCounts = observable({
    get: 0,
    create: 0,
    update: 0,
    delete: 0,
    modify: 0,
  });

  @observable errors = {};

  constructor(model, baseUrl) {
    this.model = model;
    this.path = baseUrl || model.constructor.baseUrl || model.constructor.identifiedBy;
  }

  @computed get isPending() {
    return this.requestsInProgress.size > 0;
  }

  @computed get hasBeenFetched() {
    return Boolean(
      this.requestCounts.get > 0
    );
  }

  @computed get isFetchedOrFetching() {
    return Boolean(this.isPending || this.hasBeenFetched);
  }

  @computed get baseUrl() {
    return `/api/v1/${this.path}`;
  }

  @action destroy({ id }) {
    return this.request({ model: this.model, url: `${this.baseUrl}/${id}`, method: 'delete' });
  }

  @action fetch(id) {
    return this.model.fetch({ id });
  }

  @action create(model) {
    return this.request({
      model,
      method: 'post',
      body: JSON.stringify(model.serialize()),
    });
  }

  @action save(model) {
    const { isNew } = model;
    let url = this.baseUrl;
    if (!isNew) { url += `/${model.id}`; }
    return this.request({
      url,
      model,
      method: isNew ? 'post' : 'put',
      body: JSON.stringify(model.serialize()),
    });
  }

  @action request({ model, url = this.baseUrl, method = 'get', format = '.json', body }) {
    this.requestsInProgress.set(method, true);
    return fetch(`${url}${format}`, {
      method: method.toUpperCase(),
      body,
      headers: {
        'Content-Type': 'application/json',
        Authorization: Config.jwt,
      },
    })
      .then(resp => {
        this.requestsInProgress.delete(fetch);
        this.requestCounts[method] += 1;
        model.lastServerResponse = resp;
        return resp.json && resp.status !== 204 ? // 204 == no content
          resp.json() : { success: false, message: resp.statusText };
      })
      .then(msg => {
        model.errors = null;
        if (msg.success) {
          model.fromJSON(msg.data);
        } else {
          model.errors = msg.errors || { base: msg.message };
        }
        return model;
      });
  }
}
