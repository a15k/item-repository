import { observable, computed } from 'mobx';
import { readonly } from 'core-decorators';
import Config from './config';

export default class ModelApi {

  @readonly requestsInProgress = observable.map();

  @readonly requestCounts = observable({
    read: 0,
    create: 0,
    update: 0,
    delete: 0,
    modify: 0,
  });

  @observable errors = {};

  constructor(model, baseUrl) {
    this.model = model;
    this.baseUrl = baseUrl;
  }

  @computed get isPending() {
    return this.requestsInProgress.size > 0;
  }

  @computed get hasBeenFetched() {
    return Boolean(
      this.requestCounts.read > 0
    );
  }

  @computed get isFetchedOrFetching() {
    return Boolean(this.isPending || this.hasBeenFetched);
  }

  fetch() {
    const reqHeaders = new Headers();
    reqHeaders.append('Content-Type', 'application/json');

    return fetch(`/api/v1/${this.baseUrl}/${this.model.id}.json`, {
      headers: {
        Authorization: Config.jwt,
      },
    });
  }
}
