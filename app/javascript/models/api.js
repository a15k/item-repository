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
    return this.request({ url: `${this.baseUrl}/${id}`, method: 'delete' });
  }

  @action fetch(id) {
    let url = this.baseUrl;
    if (id) { url += `/${id}`; }
    return this
      .request({ url })
      .then(json => this.model.fromJSON(json));
  }

  @action create(model) {
    return this.request({ body: JSON.stringify(model.serialize()), method: 'post' });
  }

  @action save(model) {
    return this.request({
      url: `${this.baseUrl}/${model.id}`,
      body: JSON.stringify(model.serialize()),
      method: 'put',
    });
  }

  @action request({ url = this.baseUrl, method = 'get', body }) {
    this.requestsInProgress.set(method, true);
    return fetch(`${url}.json`, {
      method: method.toUpperCase(),
      body,
      headers: {
        'Content-Type': 'application/json',
        Authorization: Config.jwt,
      },
    })
      .then(resp => 204 !== resp.status ? resp.json() : null)
      .then(json => json && json.data ? json.data : null)
      .then(json => {
        this.requestsInProgress.delete(fetch);
        this.requestCounts[method] += 1;
        return json;
      });
  }
}
