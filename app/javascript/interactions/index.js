const SCRIPT_PATTERN = /packs\/interactions-\d+-\w+\.js\?id=(.*)/;

export default class Interactions {

  constructor({ url, api }){
    Object.defineProperties(this, {
      client: {
        value: api.ApiClient.instance,
        writable: false,
      },
      url: {
        value: url,
        writable: false,
      },
      api: {
        value: api,
        writable: false,
      },
    });
    this.client.basePath = url;
  }

  set apiKey(key) {
    this.client.authentications.api_id.apiKey = `ID ${key}`;
  }

  parseIdFromScriptTag() {
    const scripts = document.querySelectorAll('script');
    for (let i = 0; i < scripts.length; ++i) {
      const match = scripts[i].src.match(SCRIPT_PATTERN);
      if (match) {
        this.apiKey = match[1];
        return true;
      }
    }
    return false;
  }


  get flags() {
    return this.flags_api || (this.flags_api = new this.api.FlagsApi());
  }

}
