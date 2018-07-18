import {
  FormGroup, Label, Input, InputGroup, InputGroupAddon, ListGroup, ListGroupItem,
} from 'reactstrap';
import Button from '../../components/button';
import { React, PropTypes, observer, observable, action, computed } from '../../helpers/react';
import Interaction from '../../models/interaction-app';
import styled from 'styled-components';
import ButtonsBar from '../../components/buttons-bar';

const EditForm = styled.form`
display: flex;
flex-direction: column;
margin: 1rem;
`;

@observer
export default class InteractionEdit extends React.Component {

  static propTypes = {
    onDone: PropTypes.func.isRequired,
    app: PropTypes.instanceOf(Interaction),
  }

  @action.bound onSave() {
    const { app } = this.props;
    app.name = this.form.querySelector('input[name="name"]').value;
    app.whitelisted_domains = this.domains;
    app.save().then(this.props.onDone);
  }

  @computed get domains() {
    const { app } = this.props;
    return observable(app ? app.whitelisted_domains.slice() : []);
  }

  @action.bound onAddDomain() {
    this.domains.push('');
  }

  @action.bound saveDomain(ev) {
    this.domains[ev.target.dataset.index] = ev.target.value;
  }

  @action.bound saveFormRef(form) {
    this.form = form;
  }

  @action.bound onRemoveDomain(ev) {
    this.domains.splice(ev.currentTarget.dataset.index, 1);
  }

  render() {
    const { app, onDone } = this.props;
    if (!app) return null;

    return (
      <EditForm innerRef={this.saveFormRef}>
        <FormGroup>
          <Label for="name">Name</Label>
          <Input type="text" name="name" id="name" defaultValue={app.name} />
        </FormGroup>
        <Label>
          <Button icon="plus" onClick={this.onAddDomain} />
          Whitelisted Domains
        </Label>
        <ListGroup>
          {this.domains.map((domain, i) => (
            <ListGroupItem key={i} data-index={i}>
              <InputGroup>
                <Input type="text" name="domain" data-index={i} onBlur={this.saveDomain} defaultValue={domain} />
                <InputGroupAddon addonType="append">
                  <Button icon="trash" data-index={i} onClick={this.onRemoveDomain} />
                </InputGroupAddon>
              </InputGroup>
            </ListGroupItem>
          ))}
        </ListGroup>
        <h3>Embed script tag</h3>
        <textarea readOnly value={app.embed_html} />
        <ButtonsBar>
          <Button icon="chevronLeft" onClick={onDone}>Cancel</Button>
          <Button icon="save" color="primary" onClick={this.onSave}>Save</Button>
        </ButtonsBar>
      </EditForm>
    );
  }

}
