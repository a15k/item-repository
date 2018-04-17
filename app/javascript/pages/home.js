import { BrowserRouter, Route, Switch } from 'react-router-dom';
import { React, action, observer } from '../helpers/react';

@observer
export default class HomePage extends React.Component {

  render() {
    return (
      <div>
        <h1>Homepage</h1>
      </div>
    );
  }

}
