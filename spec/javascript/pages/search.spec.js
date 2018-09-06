import renderer from 'react-test-renderer';
import { MemoryRouter as R } from 'react-router';
import Search from 'pages/search';
import AssessmentPreview from 'models/assessment/preview';
import SearchCollection from 'pages/search/collection';
import Factory from '../factories';

describe(Search, () => {
  let props;

  beforeEach(() => {
    const collection = new SearchCollection();
    AssessmentPreview.assets = {
      javascript: '/preview.js', stylesheet: 'preview.css',
    };
    collection.fromJSON([ Factory.create('Assessment') ]);
    props = {
      collection,
    };
  });

  it('renders help', () => {
    props.collection.assessments.clear();
    const search = renderer.create(<R><Search {...props} /></R>);
    expect(search.toJSON()).toMatchSnapshot();
    search.unmount();
  });

  it('renders search', () => {
    const search = renderer.create(<R><Search {...props} /></R>);
    expect(search.toJSON()).toMatchSnapshot();
    search.unmount();
  });

  it('performs search', () => {
    const search = mount(<R><Search {...props} /></R>);
    props.collection.search = jest.fn();
    search.find('Search').instance().inputRef.value = 'one two three';
    search.find('.input-group-append Button').simulate('click');
    expect(props.collection.search).toHaveBeenCalledWith('one two three');
    search.unmount();
  });

});
