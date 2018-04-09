import React from 'react';
import ReactDOM from 'react-dom';
import { BrowserRouter, Route } from 'react-router-dom';
import whenDomReady from 'when-dom-ready';
import HomePage from '../src/home-page';
import User from '../src/models/user';

const Root = (props, _railsContext) => {

  return (
    <BrowserRouter>
      <Route path="/" exact component={HomePage} />
    </BrowserRouter>
  );

};

whenDomReady(() => {
  const data = JSON.parse(document.getElementById('bootstrap-data').innerText);
  User.bootstrap(data);
  ReactDOM.render(<Root />, document.getElementById('application-root'));
});
