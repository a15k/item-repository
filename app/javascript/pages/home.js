import { React, observer } from '../helpers/react';
import User from '../models/user';
import { map } from 'lodash';
import { toSentence } from '../helpers/string';
import Config from '../models/config';

const NonMemberInfo = () => (
  <React.Fragment>
    <p>You are currently not a part of a network member.  If you think you should be,
      please contact the appropriate staff at your organization and they can add you
      to your organization’s member.
    </p>
    <p>
      If your organization is not currently a network member, and you are interested in joining the network, please contact us at <a href="mailto:info@a15k.org">info@a15k.org</a>.
    </p>
  </React.Fragment>
);


const MemberInfo = () => (
  <React.Fragment>
    <p>
      You are a user in the {Config.member_name} member.  Your member’s
      power {Config.member_power_users.length > 1 ? 'users are ' : 'user is '}
      {toSentence(map(Config.member_power_users, 'name'))}. Please contact them
      with questions about your organization’s membership in the network.
    </p>
    <p>
      You can access network functionality through the menu dropdowns in the upper
      right.  Have questions about how to use the network?  Take a look at the
      material on our <a href="http://develop.a15k.org">developer portal</a> or
      contact us at <a href="mailto:info@a15k.org">info@a15k.org</a>.
    </p>
  </React.Fragment>
);

@observer
export default class HomePage extends React.Component {

  render() {
    return (
      <div className="homepage">
        <h1>The Assessment Network</h1>
        <p>
          The Assessment Network (a15k), established by Rice University’s OpenStax initiative, is a community of member organizations working through sustainable business models to pool assessment items and the knowledge accrued about them.
        </p>

        {User.isMember && <MemberInfo />}
        {!User.isMember && <NonMemberInfo />}
      </div>
    );
  }

}
