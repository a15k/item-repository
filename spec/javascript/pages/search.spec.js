import renderer from 'react-test-renderer';
import Search from 'pages/search';
import SearchCollection from 'pages/search/collection';
import Factory from '../factories';

describe(Search, () => {
  let props;

  beforeEach(() => {
    const collection = new SearchCollection();
    collection.fromJSON([ Factory.create('Assessment') ]);
    props = {
      collection,
    };
  });

  it('renders help', () => {
    props.collection.assessments.clear();
    const search = renderer.create(<Search {...props} />);
    expect(search.toJSON()).toMatchSnapshot();
    search.unmount();
  });

  it('renders search', () => {
    const search = renderer.create(<Search {...props} />);
    expect(search.toJSON()).toMatchSnapshot();
    search.unmount();
  });

  it('performs search', () => {
    const search = mount(<Search {...props} />);
    props.collection.search = jest.fn();
    search.instance().inputRef.value = 'one two three';
    search.find('.input-group-append Button').simulate('click');
    expect(props.collection.search).toHaveBeenCalledWith('one two three');
    search.unmount();
  });

});
