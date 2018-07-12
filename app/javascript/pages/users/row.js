import { ListGroupItem } from 'reactstrap';
import styled from 'styled-components';
import { React, PropTypes, observer, observable, action, computed } from '../../helpers/react';
import Button from '../../components/button';
import User from '../../models/user';
import SuretyGuard from '../../components/surety-guard';

const Name = styled.div`
flex: 1;
`;

const CheckBox = styled.input.attrs({
  type: 'checkbox',
})`
margin-right: 1rem;
`;

const DeletePlaceHolder = styled.div`
min-width: 40px;
`;

@observer
class DeleteButton extends React.Component {

  static propTypes = {
    users: PropTypes.object.isRequired,
    user: PropTypes.object.isRequired,
    onSelfDelete: PropTypes.func.isRequired,
  }

  @computed get isSelf() {
    return User.id === this.props.user.id;
  }

  @computed get singlePowerUser() {
    return 1 === this.props.users.powerUsers().length;
  }

  // no deleting last power user
  @computed get usePlaceHolder() {
    return Boolean(this.isSelf && this.singlePowerUser);
  }

  @action.bound onDelete() {
    const done = this.props.users.destroy(this.props.user);
    if (this.isSelf) {
      done.then(this.props.onSelfDelete);
    }
  }

  @computed get message() {
    return this.isSelf ?
      'If you remove yourself you will be logged out and no longer be able to access A15K' :
      'Removing a user will no longer grant them access to A15K';
  }

  render() {
    if (this.usePlaceHolder) {
      return <DeletePlaceHolder />;
    }

    return (
      <SuretyGuard onConfirm={this.onDelete} message={this.message}>
        <Button icon="trash" />
      </SuretyGuard>
    );
  }

}

@observer
export default class UserRow extends React.Component {

  static propTypes = {
    users: PropTypes.object.isRequired,
    user: PropTypes.object.isRequired,
    onSelfDelete: PropTypes.func.isRequired,
    onSelfDemotion: PropTypes.func.isRequired,
  }

  @action.bound setPowerUserStatus({ currentTarget: { checked } }) {
    const { user, onSelfDemotion } = this.props;
    user.isPowerUser = checked;
    const done = this.props.user.save();
    if (User.id === user.id) {
      done.then(onSelfDemotion);
    }
  }

  render() {
    const { user, users, onSelfDelete } = this.props;

    return (
      <ListGroupItem
        key={user.id}
        data-id={user.id}
        className="d-flex align-items-center"
      >
        <Name>{user.name}</Name>
        <CheckBox checked={user.role == 'power_user'} onChange={this.setPowerUserStatus} />

        <DeleteButton onSelfDelete={onSelfDelete} users={users} user={user} />
      </ListGroupItem>
    );
  }
}
