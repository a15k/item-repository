import {
  ListGroup, ListGroupItem,
} from 'reactstrap';
import Button from '../components/button';
import { React, observer, observable, action, computed } from '../helpers/react';
import Assessment from '../models/assessment';
import InteractionApp from '../models/interaction-app';
import SwipeableViews from 'react-swipeable-views';
import Listing from './interactions/listing';
import Edit from './interactions/edit';

@observer
export default class Interactions extends React.Component {

  componentDidMount() {
    InteractionApp.collection.api.fetch();
  }

  @observable editingApp;

  @computed get currentIndex() {
    return this.editingApp ? 1 : 0;
  }

  @action.bound onAdd() {
    InteractionApp.collection.create({});
  }

  @action.bound onEdit(interaction) {
    this.editingApp = interaction;
  }

  @action.bound onEditComplete() {
    this.editingApp = null;
  }

  @action.bound onDelete(ev) {
    InteractionApp.collection.destroy({
      id: ev.currentTarget.parentElement.dataset.id,
    });
  }

  render() {
    return (
      <div className="interactions">
        <h1>
          {this.editingApp && <Button icon="chevronLeft" onClick={this.onEditComplete} />}
          {this.editingApp ? 'Back' : 'Interactions'}
        </h1>

        <SwipeableViews index={this.currentIndex}>
          <Listing onEdit={this.onEdit} />
          <Edit app={this.editingApp} onDone={this.onEditComplete} />
        </SwipeableViews>
        {!this.editingApp && <Button icon="plus" onClick={this.onAdd}>Add</Button>}
      </div>
    );
  }

}
