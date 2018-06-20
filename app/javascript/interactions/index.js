export default class Interactions {

  constructor({ url, api }){
    Object.defineProperties(this, {
      url: {
        value: url,
        writable: false,
      },
      api: {
        value: api,
        writable: false,
      },
    });

  }

  flag() {
    debugger
  }
}
