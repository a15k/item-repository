import renderer from 'react-test-renderer';
import Api from 'pages/api';

jest.mock('pages/users/delete-placeholder', () => {
  return () => <div className="delete-placeholder" />;
});

jest.mock('pages/users/disabled-power-user-toggle', () => {
  return () => <input type="checkbox" className="disabled-power-user" readOnly checked />;
});

describe(Api, () => {
  let props = {};

  it('renders combinded actions', () => {
    const api = renderer.create(<Api {...props} />, {
      createNodeMock: e => {
        return document.createElement(e.type);
      },
    });
    expect(api.toJSON()).toMatchSnapshot();
    api.unmount();
  });

});
