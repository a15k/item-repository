import {
  FormGroup, Label, Input, InputGroup, InputGroupAddon, ListGroup, ListGroupItem,
} from 'reactstrap';
import Button from '../../components/button';
import { React, PropTypes, observer, observable, action, computed, ModelCollectionType } from '../../helpers/react';
import AccessToken from '../../models/access-token';
import styled from 'styled-components';
import ButtonsBar from '../../components/buttons-bar';

const EditForm = styled.form`
display: flex;
flex-direction: column;
.token { width: 100%; }
textarea {
  width: 100%;
  padding: 1rem;
}
`;

@observer
export default class TokensEdit extends React.Component {

  static propTypes = {
    onDone: PropTypes.func.isRequired,
    isActive: PropTypes.bool.isRequired,
    token: PropTypes.instanceOf(AccessToken),
    tokens: ModelCollectionType.isRequired,
  }

  @action.bound onSave() {
    const { token } = this.props;
    const { isNew } = token;
    token.name = this.nameInput.value;
    token.save().then((tokenData) => {
      if (isNew) {
        this.props.tokens.fromJSON(tokenData);
      }
    });
  }

  @computed get nameInput() {
    return this.form.querySelector('input[name="name"]');
  }

  @action.bound saveFormRef(form) {
    this.form = form;
  }

  componentDidUpdate(prevProps) {
    if (this.props.isActive && !prevProps.isActive) {
      this.nameInput.value = this.props.token.name;
    }
  }

  renderToken() {
    const { token } = this.props;
    if (!token || token.isNew) { return null; }

    return (
      <div className="token">
        <h3>Token</h3>
        <textarea readOnly value={token ? token.token : ''} />
      </div>
    );
  }

  render() {
    const { token, onDone } = this.props;

    return (
      <EditForm innerRef={this.saveFormRef}>
        <FormGroup>
          <Label for="name">Name</Label>
          <Input
            type="text" name="name" id="name" defaultValue={token ? token.name : ''}
          />
        </FormGroup>
        {this.renderToken()}
        <ButtonsBar>
          <Button icon="chevronLeft" onClick={onDone}>Cancel</Button>
          {token && <Button icon="save" color="primary" onClick={this.onSave}>Save</Button>}
        </ButtonsBar>
      </EditForm>
    );
  }

}
