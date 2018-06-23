import Interactions from 'interactions';

describe(Interactions, () => {
  let interactions;

  beforeEach(() => {
    interactions = new Interactions({
      api: require(global.interactions.api_path),
      url: global.interactions.url,
    });
    interactions.apiKey = '123456';

  });

  it('sets api key from script tag', () => {
    const key = 'AN-123432-1';
    var s = document.createElement('script');
    s.type = 'text/javascript';

    s.src = `foo.bar.com/packs/interactions-0-jasdljflkasfads.js?id=${key}`;
    window.document.body.appendChild(s);

    expect(interactions.parseIdFromScriptTag()).toBe(true);
    expect(
      interactions.client.authentications.api_id.apiKey
    ).toEqual(`ID ${key}`);
  });

  fit('can create a flag', () => {
    interactions.api.ApiClient.instance.requestAgent = { };
    console.log(
      interactions.api.ApiClient.instance.requestAgent
    )

    return interactions.flags.createFlag({
      content_uid: '234232',
      user_uid: '123456',
      type: 'typo',
    }).then((flag) => {
      console.log(flag.id)
    }).catch(err => {
      console.error(err)
    });

  });
});
