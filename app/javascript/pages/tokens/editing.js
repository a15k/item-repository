import { FormGroup, Label, Input } from 'reactstrap';
import Button from '../../components/button';
import { React, PropTypes, observer, action, computed, ModelCollectionType } from '../../helpers/react';
import SuretyGuard from '../../components/surety-guard';
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

  @action.bound onDelete() {
    const { token, tokens, onDone } = this.props;
    tokens.destroy(token).then(onDone);
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

  renderActions() {
    return [
      <SuretyGuard
        key="d"
        onConfirm={this.onDelete}
        message="Deleting a token will immediately revoke it‘s access to the api"
      >
        <Button icon="trash">Delete</Button>
      </SuretyGuard>,
      <Button key="s" icon="save" color="primary" onClick={this.onSave}>Save</Button>,
    ];
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
          {token && this.renderActions()}
        </ButtonsBar>
      </EditForm>
    );
  }

}
