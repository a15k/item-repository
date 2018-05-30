import SwipeableViews from 'react-swipeable-views';
import Button from '../components/button';
import Listing from './tokens/listing';
import Edit from './tokens/editing';
import { React, ModelCollectionType, observer, observable, action, computed } from '../helpers/react';
import AccessToken from '../models/access-token';
import ButtonsBar from '../components/buttons-bar';

@observer
export default class Tokens extends React.Component {

  static propTypes = {
    tokens: ModelCollectionType,
  }

  static defaultProps = {
    tokens: AccessToken.collection,
  }

  componentDidMount() {
    this.props.tokens.api.fetch();
  }

  @observable editing;

  @computed get currentIndex() {
    return this.editing ? 1 : 0;
  }

  @action.bound onEdit(interaction) {
    this.editing = interaction;
  }

  @action.bound onEditComplete() {
    this.editing = null;
  }

  @action.bound onAdd() {
    this.editing = new AccessToken();
  }

  render() {
    return (
      <div className="access-tokens">
        <h1>
          Access Tokens
        </h1>
        <SwipeableViews index={this.currentIndex}>
          <Listing tokens={this.props.tokens} onEdit={this.onEdit} />
          <Edit isActive={!!this.editing} tokens={this.props.tokens} token={this.editing} onDone={this.onEditComplete} />
        </SwipeableViews>
        <ButtonsBar>
          {!this.editing && <Button icon="plus" onClick={this.onAdd}>Add</Button>}
        </ButtonsBar>
      </div>
    );
  }

}
