import { React, PropTypes, observer, action, computed } from '../../helpers/react';
import SuretyGuard from '../../components/surety-guard';
import Button from '../../components/button';
import DeletePlaceholder from './delete-placeholder';

@observer
export default class DeleteButton extends React.Component {

  static propTypes = {
    users: PropTypes.object.isRequired,
    user: PropTypes.object.isRequired,
    onSelfDelete: PropTypes.func.isRequired,
    isSelf: PropTypes.bool.isRequired,
    singlePowerUser: PropTypes.bool.isRequired,
  }


  @action.bound onDelete() {
    const done = this.props.users.destroy(this.props.user);
    if (this.props.isSelf) {
      done.then(this.props.onSelfDelete);
    }
  }

  @computed get message() {
    return this.props.isSelf ?
      'If you remove yourself you will be logged out and no longer be able to access A15K' :
      'Removing a user will no longer grant them access to A15K';
  }

  render() {
    // no deleting last power user
    if (this.props.isSelf && this.props.singlePowerUser) {
      return (
        <DeletePlaceholder />
      );
    }

    return (
      <SuretyGuard onConfirm={this.onDelete} message={this.message}>
        <Button icon="trash" />
      </SuretyGuard>
    );
  }

}
