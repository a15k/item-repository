import { computed, action } from 'mobx';
import lazyGetter from '../helpers/lazy-getter.js';
import ModelApi from './api';

export class BaseModel {

  @lazyGetter api = new ModelApi(this, 'assessments');

  fromJSON(json) {
    if(json.id) { this.id = json.id; }
    if (json.attributes) {
      this.update(json.attributes);
    }
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
