import renderer from 'react-test-renderer';
import Clipboard from 'helpers/clipboard';
import CopyOnFocusInput from 'components/copy-on-focus-input';

jest.mock('helpers/clipboard');

describe('CopyOnFocusInput', () => {
  let props;

  beforeEach(() => {
    Clipboard.copy.mockClear();
    props = {
      value: 'a string that is important',
    };
  });

  it('renders and copys when focused', () => {
    const wrapper = mount(<CopyOnFocusInput {...props} />);
    expect(Clipboard.copy).not.toHaveBeenCalled();
    wrapper.simulate('focus');
    expect(Clipboard.copy).toHaveBeenCalled();
  });

  it('can auto-focus', () => {
    props.focusOnMount = true;
    const onFocus = jest.fn();
    mount(<CopyOnFocusInput {...props} onFocus={onFocus}/>);
    expect(onFocus).toHaveBeenCalled();
  });

  it('can render a label', () => {
    props.label = 'Click me!';
    props.className = 'test-123';
    const input = mount(<CopyOnFocusInput {...props} />);
    expect(input).toRender('label');
    expect(input).toRender(`input.test-123[value="${props.value}"]`);
    expect(input.text()).toContain('Click me!');
  });

});
