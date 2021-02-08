import renderer from 'react-test-renderer';
import { MemoryRouter as R } from 'react-router';
import { Search } from 'pages/search';
import SearchCollection from 'pages/search/collection';
import Factory from '../factories';
import { saveAs } from 'file-saver/FileSaver';

jest.mock('models/iframe-settings', () => ({
  assets: { javascript: '/preview.js', stylesheet: 'preview.css' },
}));
jest.mock('file-saver/FileSaver', () => ({
  saveAs: jest.fn(),
}));

describe(Search, () => {
  let props;

  beforeEach(() => {
    const collection = new SearchCollection();

    collection.fromJSON([ Factory.create('Assessment') ]);
    props = {
      collection,
      updateSearch: jest.fn(),
    };
  });

  it('renders help', () => {
    props.collection._assessments.clear();
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
    props.query = 'foo';
    const search = mount(<R><Search {...props} /></R>);
    expect(props.collection.query).toEqual('foo');
    props.collection.fetch = jest.fn();
    search.find('Search').instance().inputRef.value = 'one two three';
    search.find('.input-group-append Button').simulate('click');
    expect(props.collection.fetch).toHaveBeenCalled();
    expect(props.collection.query).toEqual('one two three');
    expect(props.collection.page).toEqual(1);
    expect(props.collection.per_page).toEqual(10);
    search.unmount();
  });

  it('downloads raw assessment data', () => {
    const search = mount(<R><Search {...props} /></R>);
    const assessment = props.collection._assessments[0];
    search.find('Download').simulate('click');
    expect(saveAs).toHaveBeenCalledWith(expect.any(Blob), `${assessment.id}.json`);
    search.unmount();
    const blob = saveAs.mock.calls[0][0];
    const reader = new FileReader();
    return new Promise(r => {
      reader.addEventListener('loadend', () => {
        const downloaded = JSON.parse(reader.result);
        expect(downloaded).toEqual(assessment.raw);
        r();
      });
      reader.readAsText(blob);
    });
  });

});
