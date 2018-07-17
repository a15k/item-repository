import renderer from 'react-test-renderer';
import Application from 'packs/application';

jest.mock('models/user', () => ({
  isMember: true,
  username: 'bobby tables',
}));

describe(Application, () => {

  it('renders and matches snapshot', () => {
    const app = renderer.create(<Application />);
    expect(app.toJSON()).toMatchSnapshot();
    app.unmount();
  });

});
