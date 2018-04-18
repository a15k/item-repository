import { keys } from 'lodash';
import InteractionApp from 'models/interaction-app';
import Factory from '../factories';

describe(InteractionApp, () => {
  const responseUuid = 'c3e21d35-1cee-4df9-a407-0acfd9f7289f';
  const appJSON = {
    id: responseUuid,
    api_id: 'HLwDJbcYuIk=',
    api_token: 'sti0yiDHyM1S0k3FomGRewSiVbs=',
    whitelisted_domains: ['test.com'],
  };

  beforeEach(() => {
  });

  test('fetching', () => {
    const id = 123;
    fetch.mockResponseOnce(JSON.stringify([appJSON]));
    return InteractionApp.collection.api.fetch(id).then((models) => {
      expect(models).toHaveLength(1);
      expect(models[0]).toBeInstanceOf(InteractionApp);
      expect(fetch.mock.calls.length).toEqual(1);
      expect(fetch.mock.calls[0][0]).toContain(`/interactions/${id}.json`);
      expect(fetch.mock.calls[0][1]).toMatchObject({ method: 'GET' });
      const app = InteractionApp.collection.get(responseUuid);
      expect(app).not.toBeUndefined();
      expect(app).toBeInstanceOf(InteractionApp);
      expect(app.serialize()).toEqual(appJSON);
    });
  });

  test('creating', () => {
    fetch.mockResponseOnce(JSON.stringify(appJSON));
    return InteractionApp.collection.create().then((created) => {
      expect(created).toBeInstanceOf(InteractionApp);
      expect(fetch.mock.calls[0][0]).toContain('/interactions.json');
      expect(fetch.mock.calls[0][1]).toMatchObject({ method: 'POST' });
      const app = InteractionApp.collection.get(responseUuid);
      expect(app).not.toBeUndefined();
      expect(app.serialize()).toEqual(appJSON);
    });
  });

  test('deletion', () => {
    const id = 123;
    InteractionApp.collection.set(id, appJSON);
    fetch.mockResponseOnce('', { status: 204 });

    return InteractionApp.collection.destroy({ id }).then(() => {
      expect(fetch.mock.calls[0][0]).toContain(`/interactions/${id}.json`);
      expect(fetch.mock.calls[0][1]).toMatchObject({ method: 'DELETE' });
      expect(InteractionApp.collection.get(id)).toBeUndefined();
    });

  });

});
