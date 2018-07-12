import { React, PropTypes, observer, action } from '../../helpers/react';
import SuretyGuard from '../../components/surety-guard';
import DisabledPowerUserToggle from './disabled-power-user-toggle';
import CheckBox from './checkbox';

@observer
export default class PowerUserToggle extends React.Component {

  static propTypes = {
    users: PropTypes.object.isRequired,
    user: PropTypes.object.isRequired,
    isSelf: PropTypes.bool.isRequired,
    singlePowerUser: PropTypes.bool.isRequired,
    onSelfDemotion: PropTypes.func.isRequired,
  }

  @action.bound setPowerUserStatus() {
    const { user, onSelfDemotion, isSelf } = this.props;
    user.togglePowerUser();
    const done = this.props.user.save();
    if (isSelf) {
      done.then(onSelfDemotion);
    }
  }

  render() {
    const { isSelf, user, singlePowerUser } = this.props;

    if (isSelf) {
      if (singlePowerUser) {
        return <DisabledPowerUserToggle />;
      }

      return (
        <SuretyGuard
          message="After your account is modified, you will be redirected to the home page"
          onConfirm={this.setPowerUserStatus}
        >
          <CheckBox checked={user.role == 'power_user'} readOnly={true} />
        </SuretyGuard>
      );
    }

    return (
      <CheckBox checked={user.role == 'power_user'} onChange={this.setPowerUserStatus} />
    );
  }

}
