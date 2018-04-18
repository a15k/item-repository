import Edit from 'pages/integrations/edit';
import Factory from './factories';

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
    const edit = mount(<Edit {...props} />);
    expect(edit).toRender(`input[defaultValue="${props.app.name}"]`);
    console.log(edit.find('[name="name"]').debug());

    edit.find('[name="name"]').getDOMNode().value = 'my app';
    edit.find('[name="domain"]').forEach(i => {
      i.getDOMNode().value = 'foo.com';
    });
    edit.find('Button[icon="save"]').simulate('click');
    expect(app.name).toContain('my app');
    expect(app.whitelisted_domains).toContain('foo.com');
    edit.unmount();
  });

});
