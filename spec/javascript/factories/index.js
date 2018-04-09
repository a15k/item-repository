import Factory from 'object-factory-bot';
import faker from 'faker';
const { sequence, reference } = Factory;

function uuid() {
  return faker.random.uuid();
}

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


export default Factory;
