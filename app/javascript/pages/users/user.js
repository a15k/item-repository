import { ListGroupItem } from 'reactstrap';
import styled from 'styled-components';
import { React, PropTypes, observer, computed } from '../../helpers/react';
import User from '../../models/user';
import DeleteButton from './delete-button';
import PowerUserToggle from './power-user-toggle';

const Name = styled.div`
flex: 1;
`;

@observer
export default class UserRow extends React.Component {

  static propTypes = {
    users: PropTypes.object.isRequired,
    user: PropTypes.object.isRequired,
    onSelfDelete: PropTypes.func.isRequired,
    onSelfDemotion: PropTypes.func.isRequired,
  }

  @computed get isSelf() {
    return User.id === this.props.user.id;
  }

  @computed get singlePowerUser() {
    return 1 === this.props.users.powerUsers().length;
  }

  render() {
    const { user, users, onSelfDelete, onSelfDemotion } = this.props;
    const childProps = { singlePowerUser: this.singlePowerUser, isSelf: this.isSelf, users, user };

    return (
      <ListGroupItem
        key={user.id}
        data-id={user.id}
        className="d-flex align-items-center"
      >
        <Name>{user.name || user.email}</Name>
        <PowerUserToggle {...childProps} onSelfDemotion={onSelfDemotion} />
        <DeleteButton {...childProps}  onSelfDelete={onSelfDelete} />
      </ListGroupItem>
    );
  }
}
