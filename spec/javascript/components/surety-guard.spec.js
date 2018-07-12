import renderer from 'react-test-renderer';
import SuretyGuard from 'components/surety-guard';


describe(SuretyGuard, () => {
  let props;

  beforeEach(() => {
    props = {
      header:    'Sure are you?',
      message:   'Yo! are you sure?',
      placement: 'bottom',
      onConfirm: jest.fn(),
    };
  });

  it('renders', () => {
    const guard = renderer.create(
      <SuretyGuard {...props}><p>Hi</p></SuretyGuard>
    );
    expect(guard.toJSON()).toMatchSnapshot();
    guard.unmount();
  });

  // code below works but throws promise rejection warnings
  // popper can't be mocked? see Apr 5 comment on https://github.com/FezVrasta/popper.js/issues/478
  xit('renders into dom', () => {
    const guard = mount(<SuretyGuard {...props}><p>Hi</p></SuretyGuard>);
    guard.find('span').simulate('click');
    expect(
      document.body.querySelector('.popover-inner').innerHTML
    ).toMatchSnapshot();
  });

});
