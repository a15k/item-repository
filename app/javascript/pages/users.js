import { Card, ListGroup, ListGroupItem, Input, InputGroup, InputGroupAddon } from 'reactstrap';
import Button from '../components/button';
import { React, ModelCollectionType, observer, observable, action, computed } from '../helpers/react';
import User from '../models/user';
import SuretyGuard from '../components/surety-guard';
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
width: 70px;
text-align: center;
`;

const UserRow = ({ users, user }) => {
  const isSelf = User.id == user.id
  const message =  isSelf ?
    'If you remove yourself you will be logged out and no longer be able to access A15K' : 'Removing a user will no longer grant them access to A15K'

  const onDelete = () => {
    const done = users.destroy(user);
    if (isSelf) {
      done.then(User.logout);
    }
  };

  const setPowerUserStatus = ({ currentTarget: { checked } }) => {
    user.isPowerUser = checked;
    user.save();
  };

  return (
    <ListGroupItem
      key={user.id}
      data-id={user.id}
      className="d-flex align-items-center"
    >
      <Name>{user.name}</Name>
      <CheckBox checked={user.role == 'power_user'} onChange={setPowerUserStatus} />

      <SuretyGuard onConfirm={onDelete} message={message}>
        <Button icon="trash" />
      </SuretyGuard>

    </ListGroupItem>
  );
};

@observer
export default class Users extends React.Component {

  static propTypes = {
    users: ModelCollectionType,
  }

  static defaultProps = {
    users: User.constructor.collection,
  }

  componentDidMount() {
    this.props.users.api.fetch();
  }

  @action.bound onInvite() {
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
          {users.array.map((user) => <UserRow key={user.id} users={users} user={user} />)}
        </ListGroup>

        <InputGroup className="invite-user" style={{ marginTop: 30 }}>
          <InputGroupAddon addonType="prepend">
            Invite email:
          </InputGroupAddon>
          <Input type="email" innerRef={(e) => this.invite = e} name="email" />
          <InputGroupAddon addonType="append">
            <Button icon="envelope" onClick={this.onInvite} />
          </InputGroupAddon>
        </InputGroup>
        <ErrorDisplay errors={users.errors} />
      </div>
    );
  }

}
