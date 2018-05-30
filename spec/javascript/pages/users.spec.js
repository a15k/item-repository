import renderer from 'react-test-renderer';
import Users from 'pages/users';
import Factory from '../factories';

describe(Users, () => {
  let props;

  beforeEach(() => {
    const users = Factory.usersCollection({ count: 3 });
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
    const delBtn = users.find(`ListGroupItem[data-id="${user.id}"] Button[icon="trash"]`);
    props.users.destroy = jest.fn();
    delBtn.simulate('click');
    expect(props.users.destroy).toHaveBeenCalledWith(user);
    users.unmount();
  });

});
