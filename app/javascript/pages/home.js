import { React, observer } from '../helpers/react';
import User from '../models/user';

const NoMemberMessage = () => (
  <div className="not-a-member">
    <h3>Your account does not belong to any A15K member organizations</h3>
    <p>
      Please contact the A15K representative at your organization and ask
      them to invite your email address.
    </p>
  </div>
);


@observer
export default class HomePage extends React.Component {

  render() {
    if (!User.isMember) {
      return <NoMemberMessage />;
    }

    return (
      <div>
        <h1>Homepage</h1>
      </div>
    );
  }

}
