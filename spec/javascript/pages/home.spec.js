import renderer from 'react-test-renderer';
import Home from 'pages/home';
import User from 'models/user';

jest.mock('models/user', () => ({
  isMember: true,
}));

describe(Home, () => {

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
    expect(home).toRender('NoMemberMessage');
    home.unmount();
  });

});
