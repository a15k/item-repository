import Factory from 'object-factory-bot';
import { times } from 'lodash';
import faker from 'faker';
const { sequence, reference } = Factory;
import ModelCollection from 'models/model-collection';
import Interaction from 'models/interaction-app';

function uuid() {
  return faker.random.uuid();
}

Factory.define('InteractionApp')
  .id(uuid)
  .name(faker.company.bsAdjective)
  .api_id('HLwDJbcYuIk=')
  .api_token('sti0yiDHyM1S0k3FomGRewSiVbs=')
  .whitelisted_domains(() =>[faker.internet.domainName()]);

Factory.define('Format')
  .id(uuid)
  .identifier(faker.lorem.word)
  .name(faker.company.companyName())
  .description(faker.company.catchPhrase);

Factory.define('Accessment')
  .id(uuid)
  .attributes(reference('AccessmentAttributes'));

Factory.define('AccessmentAttributes')
  .format_identifier(({ format }) => format ? format.identifier : faker.lorem.word())
  .contents(() => JSON.stringify({
    preamble: faker.company.catchPhrase(),
  }));

Factory.interactionsCollection = ({ count = 3 } = {}) => {
  const collection = new ModelCollection(Interaction);
  times(count, () => collection.fromJSON(Factory.create('InteractionApp')));
  return collection;
};

export default Factory;
