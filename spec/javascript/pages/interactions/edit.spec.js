import Edit from 'pages/interactions/edit';
import Factory from '../../factories';

describe(Edit, () => {
  let props, app;

  beforeEach(() => {
    const collection = Factory.interactionsCollection({ count: 1 });
    app = collection.array[0];

    props = {
      onDone: jest.fn(),
      app,
    };
  });

  it('displays values', () => {
    fetch.mockResponseOnce(JSON.stringify({
      data: {
        name: 'my app', whitelisted_domains: ['foo.com'],
      },
    }));

    const edit = mount(<Edit {...props} />);
    expect(edit).toRender(`input[defaultValue="${props.app.name}"]`);
    edit.find('[name="name"][className="form-control"]').getDOMNode().value = 'my app';
    edit.find('[name="domain"][className="form-control"]').forEach(i => {
      i.getDOMNode().value = 'foo.com';
      i.simulate('blur');
    });
    edit.find('Button[icon="save"]').simulate('click');
    expect(fetch.mock.calls.length).toEqual(1);
    expect(JSON.parse(fetch.mock.calls[0][1].body)).toMatchObject({
      name: 'my app',
      whitelisted_domains: ['foo.com'],
    });
    expect(app.name).toContain('my app');
    edit.unmount();
  });

});
