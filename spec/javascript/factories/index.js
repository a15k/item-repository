import Factory from 'object-factory-bot';
import { times } from 'lodash';
import faker from 'faker';
const { sequence, reference } = Factory;
import ModelCollection from 'models/model-collection';
import Interaction from 'models/interaction-app';
import AccessToken from 'models/access-token';
import { User } from 'models/user';

function uuid() {
  return faker.random.uuid();
}

Factory.setSeed = (seed) => faker.seed(seed);

Factory.define('AccessToken')
  .id(uuid)
  .name(faker.commerce.department)
  .token(() => times(4, () => uuid()).join('-'));

Factory.define('InteractionApp')
  .id(uuid)
  .name(faker.company.bsAdjective)
  .api_id('HLwDJbcYuIk=')
  .api_token('sti0yiDHyM1S0k3FomGRewSiVbs=')
  .whitelisted_domains(() =>[faker.internet.domainName()]);

Factory.define('Format')
  .id(uuid)
  .identifier(faker.lorem.word)
  .name(faker.company.companyName)
  .description(faker.company.catchPhrase);

Factory.define('Accessment')
  .id(uuid)
  .attributes(reference('AccessmentAttributes'));

Factory.define('User')
  .id(uuid)
  .name(() => faker.name.findName())
  .username(faker.internet.userName)
  .role(() => faker.random.arrayElement(['power_user', 'standard_user']));

Factory.define('AccessmentAttributes')
  .format_identifier(({ format }) => format ? format.identifier : faker.lorem.word())
  .contents(() => JSON.stringify({
    preamble: faker.company.catchPhrase(),
  }));


const buildCollection = (model, factory) => (
  ({ count = 3 } = {}) => {
    const collection = new ModelCollection(model);
    times(count, () => collection.fromJSON(Factory.create(factory)));
    return collection;
  });

Factory.usersCollection = buildCollection(User, 'User');
Factory.interactionsCollection = buildCollection(Interaction, 'InteractionApp');
Factory.accessTokenCollection = buildCollection(AccessToken, 'AccessToken');

export default Factory;
