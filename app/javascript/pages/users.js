import { ListGroup, Input, InputGroup, InputGroupAddon, Alert } from 'reactstrap';
import { Redirect } from 'react-router-dom';
import Button from '../components/button';
import { React, ModelCollectionType, observer, observable, action } from '../helpers/react';
import User from '../models/user';
import Config from '../models/config';
import ErrorDisplay from '../components/model-errors';
import styled from 'styled-components';
import UserRow from './users/user';
import SectionHeading from '../components/section-heading';

const DeleteLabel = styled.div`
width: 70px;
text-align: center;
`;

const InvitedNotice = styled(Alert).attrs({ color: 'info' })`
margin-top: 20px;
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
  @observable inviteDeliveredTo = false;

  @action.bound onSelfDelete() {
    User.member_id = null;
    this.redirectToHome = true;
  }

  @action.bound onSelfDemotion() {
    User.role = 'standard_user';
    this.redirectToHome = true;
  }

  @action.bound onInviteMessageHide() {
    this.inviteDeliveredTo = false;
  }

  @action.bound onInvite() {
    this.props.users.invite(this.invite.value).then(() => {
      if (!this.invite) return; // we were unmounted
      this.inviteDeliveredTo = this.invite.value;
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
        <SectionHeading>
          <h3>Users for member {Config.member_name}</h3>
        </SectionHeading>

        <InputGroup className="invite-user" style={{ marginTop: 30 }}>
          <InputGroupAddon addonType="prepend">
            Invite email:
          </InputGroupAddon>
          <Input type="email" innerRef={(e) => this.invite = e} name="email" />
          <InputGroupAddon addonType="append">
            <Button icon="envelope" onClick={this.onInvite} />
          </InputGroupAddon>
        </InputGroup>

        <InvitedNotice
          isOpen={!!this.inviteDeliveredTo}
          toggle={this.onInviteMessageHide}
        >
          If {this.inviteDeliveredTo} already has an account, they can now access a15k.  If not, an invitation email has been sent.
        </InvitedNotice>

        <ErrorDisplay errors={users.errors} />

        <div className="d-flex justify-content-end">
          PowerUser?
          <DeleteLabel>Delete</DeleteLabel>
        </div>

        <ListGroup>
          {users.array.map((user) =>
            <UserRow
              key={user.id}
              onSelfDemotion={this.onSelfDemotion}
              onSelfDelete={this.onSelfDelete}
              users={users}
              user={user} />)}
        </ListGroup>

      </div>
    );
  }

}
