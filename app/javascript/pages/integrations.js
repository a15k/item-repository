import {
  InputGroupButtonDropdown, DropdownToggle, DropdownMenu, DropdownItem,
  InputGroup, InputGroupAddon, Input,
} from 'reactstrap';
import Button from '../components/button';
import { React, observer, observable, action } from '../helpers/react';
import Assessment from '../models/assessment';
import Interactions from '../models/interaction-app';

@observer
export default class Integrations extends React.Component {

  componentDidMount() {
    Interactions.collection.api.fetch();
  }

  @action.bound onAdd() {
    Interactions.collection.create({});
  }

  @action.bound onDelete(ev) {
    Interactions.collection.destroy({
      id: ev.currentTarget.parentElement.dataset.id,
    });
  }

  render() {

    const apps = Interactions.collection.array;

    return (
      <div className="integrations">
        <h1>integrations</h1>
        <ul>
          {apps.map(app =>
            <li key={app.id} data-id={app.id}>
              <Button icon="trash" onClick={this.onDelete} />
              {app.id}
            </li>
          )}
        </ul>
        <Button icon="plus" onClick={this.onAdd}>Add</Button>
      </div>
    );
  }

}
