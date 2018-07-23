import React from 'react';
import Enzyme from 'enzyme';
import Adapter from 'enzyme-adapter-react-16';
import fetch from 'jest-fetch-mock';
import * as enzymeMatchers from '@commercetools/jest-enzyme-matchers'
import Factory from './factories';
import 'jest-styled-components'

Enzyme.configure({ adapter: new Adapter() });
expect.extend(enzymeMatchers);

global.React = React;
global.fetch = fetch;
global.mount = Enzyme.mount;

beforeEach(() => {
  Factory.setSeed(1234);
  fetch.resetMocks();
});


global.testhelper = {

  async waitUntil(fnWait) {
    return new Promise((resolve, reject) => {
      let count = 0;
      function check() {
        if (++count > 20) {
          reject(new TypeError('Timeout waiting for fn to return true'));
          return;
        }
        if (fnWait()) resolve();
        setTimeout(check, 10);
      }
      check();
    });
  }

}
