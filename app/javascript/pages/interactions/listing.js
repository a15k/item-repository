import {
  ListGroup, ListGroupItem,
} from 'reactstrap';
import Button from '../../components/button';
import { React, PropTypes, observer, observable, action, ModelCollectionType } from '../../helpers/react';
import Interactions from '../../models/interaction-app';

@observer
export default class InteractionsListing extends React.Component {

  static propTypes = {
    onEdit: PropTypes.func.isRequired,
    apps: ModelCollectionType,
  }

  static defaultProps = {
    apps: Interactions.collection,
  }

  @action.bound onEdit(ev) {
    this.props.onEdit(
      this.props.apps.get(
        ev.currentTarget.parentElement.dataset.id
      )
    );
  }

  render() {
    const { apps } = this.props;

    return (
      <ListGroup>
        {apps.array.map(app =>
          <ListGroupItem
            key={app.id}
            data-id={app.id}
            className="d-flex justify-content-between"
          >
            {app.id}
            <Button icon="chevronRight" onClick={this.onEdit} />
          </ListGroupItem>
        )}
      </ListGroup>
    );
  }

}
