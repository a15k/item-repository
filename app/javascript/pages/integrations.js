import {
  ListGroup, ListGroupItem,
} from 'reactstrap';
import Button from '../components/button';
import { React, observer, observable, action, computed } from '../helpers/react';
import Assessment from '../models/assessment';
import Interactions from '../models/interaction-app';
import SwipeableViews from 'react-swipeable-views';
import Listing from './integrations/listing';
import Edit from './integrations/edit';

@observer
export default class Integrations extends React.Component {

  componentDidMount() {
    Interactions.collection.api.fetch()
      .then(() => {
        this.editingIntegration = Interactions.collection.array[0]

      });
  }

  @observable editingIntegration;

  @computed get currentIndex() {
    return this.editingIntegration ? 1 : 0;
  }

  @action.bound onAdd() {
    Interactions.collection.create({});
  }

  @action.bound onEdit(interaction) {
    this.editingIntegration = interaction;
  }

  @action.bound onEditComplete() {
    this.editingIntegration = null;
  }

  @action.bound onDelete(ev) {
    Interactions.collection.destroy({
      id: ev.currentTarget.parentElement.dataset.id,
    });
  }

  render() {
    return (
      <div className="integrations">
        <h1>integrations</h1>
        <SwipeableViews index={this.currentIndex}>
          <Listing onEdit={this.onEdit} />
          <Edit app={this.editingIntegration} onDone={this.onEditComplete} />
        </SwipeableViews>
        <Button icon="plus" onClick={this.onAdd}>Add</Button>
      </div>
    );
  }

}
