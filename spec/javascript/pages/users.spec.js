import renderer from 'react-test-renderer';
import Users from 'pages/users';
import Factory from '../factories';
import User from 'models/user';

jest.mock('models/user', () => ({
  id: 1,
}));
jest.mock('models/config', () => ({
  member_name: 'Illuminati',
}));
jest.mock('pages/users/delete-placeholder', () => {
  return () => <div className="delete-placeholder" />;
});

jest.mock('pages/users/disabled-power-user-toggle', () => {
  return () => <input type="checkbox" className="disabled-power-user" readOnly checked />;
});

describe(Users, () => {
  let props;

  const setSinglePowerUser = () => {
    const user = props.users.array[2];
    props.users.powerUsers = () => [ user ];
    props.users.map.replace({ [`${user.id}`]: user });
    return user;
  };

  beforeEach(() => {
    const users = Factory.usersCollection({ count: 3 });
    users.powerUsers = () => [ ];

    users.api.fetch = jest.fn(() => Promise.resolve({ data: [] }));
    props = {
      users,
    };
  });

  it('renders listing', () => {
    const users = renderer.create(<Users {...props} />);
    expect(users.toJSON()).toMatchSnapshot();
    users.unmount();
  });

  it('can delete a user', () => {
    const users = mount(<Users {...props} />);
    const user = props.users.array[1];
    const delBtn = users.find(`ListGroupItem[data-id="${user.id}"] SuretyGuard`);
    props.users.destroy = jest.fn();
    delBtn.props().onConfirm();
    expect(props.users.destroy).toHaveBeenCalledWith(user);
    users.unmount();
  });

  it('hides delete for last power user', () => {
    const user = setSinglePowerUser();
    const users = mount(<Users {...props} />);
    expect(users.find('ListGroupItem').length).toEqual(1);
    expect(users).toRender('DeleteButton Button');
    user.id = 1;
    users.update();
    expect(users).not.toRender('DeleteButton Button');
    users.unmount();
  });

  it('de-activates toggle for last power user', () => {
    const user = setSinglePowerUser();
    user.id = 1;
    const users = mount(<Users {...props} />);
    expect(users).toRender('PowerUserToggle input[readOnly]');
    users.unmount();
  });

  describe('invitations', () => {
    it('can invite users', () => {
      const users = mount(<Users {...props} />);
      users.instance().invite.value = 'newUserOne@test.com';
      props.users.invite = jest.fn(() => Promise.resolve());
      users.find('[icon="envelope"] .btn-secondary').simulate('click');
      expect(props.users.invite).toHaveBeenCalledWith('newUserOne@test.com');
      users.unmount();
    });

    it('displays message', async () => {
      const users = mount(<Users {...props} />);
      users.instance().invite.value = 'bob@test.com';
      props.users.invite = jest.fn(() => Promise.resolve());
      users.find('[icon="envelope"] .btn-secondary').simulate('click');
      expect(props.users.invite).toHaveBeenCalled();
      await testhelper.waitUntil(() => users.instance().inviteDeliveredTo)
      expect(users.find('Alert[color="info"]').text()).toContain('email has been sent to bob@test.com');
      users.unmount();
    });

    it('displays errors', () => {
      const users = mount(<Users {...props} />);
      users.instance().invite.value = 'not-an-email';
      props.users.invite = jest.fn(function() {
        this.errors = { base: 'unable to invite user' };
        return Promise.resolve();
      });
      users.find('[icon="envelope"] .btn-secondary').simulate('click');
      expect(props.users.invite).toHaveBeenCalled();
      expect(users.find('Alert[className="model-errors"]').text()).toEqual('unable to invite user');
      users.unmount();

    });


  });

});
