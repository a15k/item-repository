import Assessment from 'models/assessment';
import Factory from '../factories';

describe(Assessment, () => {

  test('bootstrapping', () => {
    const a = new Assessment();
    const format = Factory.create('Format');
    const factory = Factory.create('Accessment', { attributes: { format: format } });
    a.fromJSON(factory);
    expect(a.contents).toEqual(factory.attributes.contents);
    expect(a.format_identifier).toEqual(format.identifier);
  });

});
