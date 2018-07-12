import { Card, ListGroup, ListGroupItem, Input, InputGroup, InputGroupAddon } from 'reactstrap';
import { Redirect } from 'react-router-dom';
import Button from '../components/button';
import { React, ModelCollectionType, observer, observable, action } from '../helpers/react';
import User from '../models/user';
import ErrorDisplay from '../components/model-errors';
import styled from 'styled-components';
import UserRow from './users/row';


const DeleteLabel = styled.div`
width: 70px;
text-align: center;
`;


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

  @observable redirectToHome = false;

  @action.bound onSelfDelete() {
    User.member_id = null;
    this.redirectToHome = true;
  }

  @action.bound onInvite() {
    this.props.users.invite(this.invite.value).then(() => {
      this.invite.value = '';
      this.invite.focus();
    });
  }

  render() {
    const { users } = this.props;

    if (this.redirectToHome) {
      return <Redirect to="/" />;
    }

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
            <UserRow key={user.id} onSelfDelete={this.onSelfDelete} users={users} user={user} />)}
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
