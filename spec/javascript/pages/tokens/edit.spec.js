import Edit from 'pages/tokens/editing';
import Factory from '../../factories';
import renderer from 'react-test-renderer';
jest.mock('components/surety-guard', () => ({ onConfirm, children }) => (
  <span className="surety-guard" onClick={onConfirm}>{children}</span>
));


describe(Edit, () => {
  let props;
  let tokens;

  beforeEach(() => {
    tokens = Factory.accessTokenCollection({ count: 1 });
    props = {
      tokens,
      isActive: true,
      onDone: jest.fn(),
      token: tokens.array[0],
    };
  });

  it('matches snapshot', () => {
    const edit = renderer.create(<Edit {...props} />);
    expect(edit.toJSON()).toMatchSnapshot();
    edit.unmount();
  });

  it('calls delete', () => {
    tokens.destroy = jest.fn(() => Promise.resolve());
    const edit = mount(<Edit {...props} />);
    edit.find('Button[icon="trash"]').simulate('click');
    expect(tokens.destroy).toHaveBeenCalled();
    edit.unmount();
  });

  it('displays and edits values', () => {
    fetch.mockResponseOnce(JSON.stringify({
      data: { name: 'my app', token: '1234' },
    }));

    const edit = mount(<Edit {...props} />);
    expect(edit).toRender(`input[defaultValue="${props.token.name}"]`);
    edit.find('[name="name"][className="form-control"]').getDOMNode().value = 'my token';
    edit.find('Button[icon="save"]').simulate('click');
    expect(fetch.mock.calls.length).toEqual(1);
    expect(JSON.parse(fetch.mock.calls[0][1].body)).toMatchObject({
      name: 'my token',
    });
    expect(props.token.name).toContain('my token');
    edit.unmount();
  });


});
