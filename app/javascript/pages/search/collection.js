import { computed, action, observable } from 'mobx';
import Assessment from '../../models/assessment';
import lazyGetter from '../../helpers/lazy-getter.js';
import ModelApi from '../../models/api';

export default class SearchCollection {

  @observable assessments = [];
  @lazyGetter api = new ModelApi(this, 'assessments');

  @observable isLoading = false;

  @action search(q) {
    this.isLoading = true;
    return this.api.request({ model: this, query: { q } })
      .then(() => {
        this.isLoading = false;
      });
  }

  fromJSON(models) {
    this.assessments.replace(
      models.map(a => new Assessment(a))
    );
  }

  @action.bound fetchById(id) {
    this.isLoading = true;
    return Assessment
      .fetch({ id })
      .then((assessment) => {
        this.assessments.replace([assessment]);
        this.isLoading = false;
      });
  }

  map(fn) {
    return this.assessments.map(fn);
  }
}
