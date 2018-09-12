import { action, observable, computed } from 'mobx';
import { pick } from 'lodash';
import Assessment from '../../models/assessment';
import lazyGetter from '../../helpers/lazy-getter.js';
import ModelApi from '../../models/api';
import qs from 'query-string';

export default class SearchCollection {

  @observable _assessments = [];
  @lazyGetter api = new ModelApi(this, 'assessments');

  @observable isLoading = false;
  @observable total_count;
  @observable per_page = 10;
  @observable page = 1;
  @observable query = '';

  @action update(values) {
    Object.assign(this, {
      query: values.query ? values.query : this.query,
      page: values.page ? parseInt(values.page) : this.page,
      per_page: values.per_page ? parseInt(values.per_page) : this.per_page,
    });
    this._assessments.clear();
    return this;
  }

  @action fetch() {
    if (!this.query) { return Promise.resolve(this); }
    return this.api.request(
      { model: this, query: pick(this, 'query', 'per_page', 'page') }
    );
  }

  fromJSON(models, { total_count } = {}) {
    this.total_count = total_count;
    this._assessments.replace(models.map(a => new Assessment(a)));
  }

  map(fn) {
    return this._assessments.map(fn);
  }

  @computed get queryParams() {
    return qs.stringify(pick(this, 'query', 'page', 'per_page'));
  }

  @computed get isEmpty() {
    return !this._assessments.length;
  }

  @computed get pageCount() {
    if (!this.total_count) { return 1; }
    return Math.ceil(this.total_count / this.per_page);
  }
}
