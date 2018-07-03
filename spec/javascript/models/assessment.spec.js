import Assessment from 'models/assessment';
import Factory from '../factories';

describe(Assessment, () => {

  test('bootstrapping', () => {
    const a = new Assessment();
    const format = Factory.create('Format');
    const factory = Factory.create('Assessment', { format_id: format.id } );
    a.fromJSON(factory);
  });

});
