import renderer from 'react-test-renderer';
import { MemoryRouter as R } from 'react-router';
import Formats from 'pages/formats';
import FormatModel from 'models/format';
import Collection from 'models/model-collection';
import Factory from '../factories';

describe('Formats Page', () => {
  let props;

  beforeEach(() => {
    const collection = new Collection(FormatModel);
    collection.fromJSON([ Factory.create('Assessment') ]);
    props = {
      collection,
    };
  });

  it('renders formats', () => {
    props.collection.fromJSON([{ id: '1234', name: 'Test Format' }]);
    props.collection.api.requestCounts.get +=1;
    const search = renderer.create(<R><Formats {...props} /></R>);
    expect(search.toJSON()).toMatchSnapshot();
    search.unmount();
  });
});
