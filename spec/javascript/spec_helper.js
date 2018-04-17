global.fetch = require('jest-fetch-mock');

beforeEach(() => {
  fetch.resetMocks();
});
