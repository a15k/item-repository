import { Card, ListGroup, ListGroupItem, Input, InputGroup, InputGroupAddon } from 'reactstrap';
import Button from '../components/button';
import { React, ModelCollectionType, observer, observable, action, computed } from '../helpers/react';
import { User } from '../models/user';
import ErrorDisplay from '../components/model-errors';
import styled from 'styled-components';

const Name = styled.div`
flex: 1;
`;
const CheckBox = styled.input.attrs({
  type: 'checkbox',
})`
margin-right: 1rem;
`;
const DeleteLabel = styled.div`
width: 80;
textAlign: center;
`;
@observer
export default class Users extends React.Component {

  static propTypes = {
    users: ModelCollectionType,
  }

  static defaultProps = {
    users: User.collection,
  }

  componentDidMount() {
    this.props.users.api.fetch();
  }

  @action.bound onDelete(ev) {
    const user = this.props.users.get(ev.currentTarget.parentElement.dataset.id);
    this.props.users.destroy(user);
  }

  @action.bound setPowerUserStatus(ev) {
    const user = this.props.users.get(ev.currentTarget.parentElement.dataset.id);
    user.isPowerUser = ev.currentTarget.checked;
    user.save();
  }

  @action.bound onInvite(ev) {
    this.props.users.invite(this.invite.value).then(() => {
      this.invite.value = '';
      this.invite.focus();
    });
  }

  render() {
    const { users } = this.props;
    return (
      <div className="access-users">
        <h1>
          Users
        </h1>

        <div className="d-flex justify-content-end">
          PowerUser?
          <DeleteLabel>Delete</DeleteLabel>
        </div>

        <ListGroup>
          {users.array.map((user) =>
            <ListGroupItem
              key={user.id}
              data-id={user.id}
              className="d-flex align-items-center"
              >
              <Name>{user.name}</Name>
              <CheckBox checked={user.isPowerUser} onChange={this.setPowerUserStatus} />
              <Button icon="trash" onClick={this.onDelete} />
            </ListGroupItem>
          )}
        </ListGroup>

        <InputGroup style={{ marginTop: 30 }}>
          <InputGroupAddon addonType="prepend">
            Invite username:
          </InputGroupAddon>
          <Input innerRef={(e) => this.invite = e} type="text" name="username" />
          <InputGroupAddon addonType="append">
            <Button icon="save" onClick={this.onInvite} />
          </InputGroupAddon>
        </InputGroup>

        <br />

        <ErrorDisplay errors={users.errors} />

      </div>
    );
  }

}
