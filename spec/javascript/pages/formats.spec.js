import renderer from 'react-test-renderer';
import { MemoryRouter as R } from 'react-router';
import { Formats } from 'pages/formats';
import FormatModel from 'models/format';
import Collection from 'models/model-collection';
import Factory from '../factories';

jest.mock('models/iframe-settings', () => ({
  assets: { javascript: '/preview.js', stylesheet: 'preview.css' },
}));

describe('Formats Page', () => {
  let props;

  beforeEach(() => {
    const collection = new Collection(FormatModel);
    collection.fromJSON([ Factory.create('Format') ]);
    collection.fromJSON([{
      id: '1234', name: 'Test Format',
      specification: 'This is <b>the best</b> format',
    }]);
    collection.api.requestCounts.get +=1;
    props = {
      match: { params: {} },
      collection,
      history: { push: jest.fn() },
    };
  });

  it('renders formats listing', () => {
    const search = renderer.create(<R><Formats {...props} /></R>);
    expect(search.toJSON()).toMatchSnapshot();
    search.unmount();
  });

  it('renders a format spec', () => {
    props.match.params.id = props.collection.array[0].id;
    const search = renderer.create(<Formats {...props} />);
    expect(search.toJSON()).toMatchSnapshot();
    search.unmount();
  });

});
