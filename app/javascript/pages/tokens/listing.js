import {
  ListGroup, ListGroupItem,
} from 'reactstrap';
import Button from '../../components/button';
import { React, PropTypes, observer, observable, action, ModelCollectionType } from '../../helpers/react';
import AccessToken from '../../models/access-token';

@observer
export default class TokensListing extends React.Component {

  static propTypes = {
    onEdit: PropTypes.func.isRequired,
    tokens: ModelCollectionType.isRequired,
  }

  static defaultProps = {
    tokens: AccessToken.collection,
  }

  @action.bound onEdit(ev) {
    this.props.onEdit(
      this.props.tokens.get(
        ev.currentTarget.parentElement.dataset.id
      )
    );
  }

  render() {
    const { tokens } = this.props;
    return (
      <ListGroup>
        {tokens.array.map((token) =>
          <ListGroupItem
            key={token.id}
            data-id={token.id}
            className="d-flex justify-content-between align-items-center"
          >
            <div>{token.name}</div>
            <Button icon="chevronRight" onClick={this.onEdit} />
          </ListGroupItem>
        )}
      </ListGroup>
    );
  }

}
