import renderer from 'react-test-renderer';
import Home from 'pages/home';
import User from 'models/user';
import Config from 'models/config';

jest.mock('models/config', () => ({
  member_name: 'Testing McTest U',
  member_power_users: [],
}));

jest.mock('models/user', () => ({
  isMember: true,
}));

describe(Home, () => {

  beforeEach(() => {
    User.isMember = true;
    Config.member_power_users = [{ name: 'Bob' }, { name: 'Jane' }];
  });

  it('renders for member users', () => {
    const home = renderer.create(<Home />);
    expect(home.toJSON()).toMatchSnapshot();
    home.unmount();
  });

  it('renders a non-member message', () => {
    User.isMember = false;

    let home = renderer.create(<Home />);
    expect(home.toJSON()).toMatchSnapshot();
    home.unmount();

    home = mount(<Home />);
    expect(home).toRender('NonMemberInfo');
    home.unmount();
  });

  it('renders with single power users listed', () => {
    Config.member_power_users = [{ name: 'The Only One' }];
    const home = renderer.create(<Home />);
    expect(home.toJSON()).toMatchSnapshot();
    home.unmount();
  });

});
