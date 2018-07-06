import { ListGroupItem } from 'reactstrap';
import styled from 'styled-components';
import { React, observer } from '../../helpers/react';
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

const DeleteButton = ({ users, user }) => {
  const isSelf = User.id === user.id;

  // no deleting last power user
  if (isSelf && users.powerUsers().length == 1) {
    return <DeletePlaceHolder />;
  }

  const message =  isSelf ?
    'If you remove yourself you will be logged out and no longer be able to access A15K' : 'Removing a user will no longer grant them access to A15K'

  const onDelete = () => {
    const done = users.destroy(user);
    if (isSelf) {
      done.then(User.logout);
    }
  };

  return (
    <SuretyGuard onConfirm={onDelete} message={message}>
      <Button icon="trash" />
    </SuretyGuard>
  );
};

const UserRow = observer(({ users, user }) => {

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

      <DeleteButton users={users} user={user} />
    </ListGroupItem>
  );
});

export default UserRow;
