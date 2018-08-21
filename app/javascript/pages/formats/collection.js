import { action, observable } from 'mobx';
import Format from '../../models/format';
import lazyGetter from '../../helpers/lazy-getter.js';
import ModelApi from '../../models/api';

export default class SearchCollection {

  @observable formats = [];
  @lazyGetter api = new ModelApi(this, 'formats');

  @observable isLoading = false;

  @action search(q) {
    this.isLoading = true;
    return this.api.request({ model: this, query: { q } })
      .then(() => {
        this.isLoading = false;
      });
  }

  fromJSON(models) {
    this.formats.replace(
      models.map(a => new Format(a))
    );
  }

  @action.bound fetchById(id) {
    this.isLoading = true;
    return Format
      .fetch({ id })
      .then((format) => {
        this.formats.replace([format]);
        this.isLoading = false;
      });
  }

  map(fn) {
    return this.formats.map(fn);
  }
}
