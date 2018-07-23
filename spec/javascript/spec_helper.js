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
