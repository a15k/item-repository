import {

  ListGroup, ListGroupItem,
} from 'reactstrap';
import SwipeableViews from 'react-swipeable-views';
import Button from '../components/button';
import Listing from './tokens/listing';
import Edit from './tokens/editing';
import { React, ModelCollectionType, observer, observable, action, computed } from '../helpers/react';
import AccessTokens from '../models/access-token';

@observer
export default class Tokens extends React.Component {

  static propTypes = {
    tokens: ModelCollectionType,
  }

  static defaultProps = {
    tokens: AccessTokens.collection,
  }

  componentDidMount() {
    this.props.tokens.api.fetch();
  }

  @observable editing;

  @computed get currentIndex() {
    return this.editing ? 1 : 0;
  }

  // @action.bound onAdd() {
  //   InteractionApp.collection.create({});
  // }

  @action.bound onEdit(interaction) {
    this.editing = interaction;
  }

  @action.bound onEditComplete() {
    this.editing = null;
  }

  // @action.bound onDelete(ev) {
  //   InteractionApp.collection.destroy({
  //     id: ev.currentTarget.parentElement.dataset.id,
  //   });
  // }

  render() {
    return (
      <div className="access-tokens">
        <h1>
          Access Tokens
        </h1>
        <SwipeableViews index={this.currentIndex}>
          <Listing tokens = {this.props.tokens} onEdit={this.onEdit} />
          <Edit token={this.editing} onDone={this.onEditComplete} />
        </SwipeableViews>
        <Button icon="plus" onClick={this.onAdd}>Add</Button>
      </div>
    );
  }

}
