import renderer from 'react-test-renderer';
import Tokens from 'pages/tokens';
import Factory from '../factories';

describe(Tokens, () => {
  let props;

  beforeEach(() => {
    const tokens = Factory.accessTokenCollection({ count: 3 });
    tokens.api.fetch = jest.fn();
    props = {
      onDone: jest.fn(),
      tokens,
    };
  });

  it('renders listing, and toggles to edit', () => {
    const tokens = mount(<Tokens {...props} />);
    expect(tokens).toRender('ReactSwipableView[index=0]');
    tokens.find('Button[icon="chevronRight"]').first().simulate('click');
    expect(tokens).toRender('ReactSwipableView[index=1]');
    tokens.unmount();
  });

});
