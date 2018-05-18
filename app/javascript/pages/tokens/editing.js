import {
  FormGroup, Label, Input, InputGroup, InputGroupAddon, ListGroup, ListGroupItem,
} from 'reactstrap';
import Button from '../../components/button';
import { React, PropTypes, observer, observable, action, computed } from '../../helpers/react';
import AccessToken from '../../models/access-token';
import styled from 'styled-components';

const EditForm = styled.form`
display: flex;
flex-direction: column;
margin: 1rem;
textarea {
  padding: 1rem;
}
`;

@observer
export default class TokensEdit extends React.Component {

  static propTypes = {
    onDone: PropTypes.func.isRequired,
    token: PropTypes.instanceOf(AccessToken),
  }

  @action.bound onSave() {
    const { token } = this.props;
    token.name = this.form.querySelector('input[name="name"]').value;
    token.save();
  }

  @action.bound saveFormRef(form) {
    this.form = form;
  }

  render() {
    const { token } = this.props;
    if (!token) return null;

    return (
      <EditForm innerRef={this.saveFormRef}>
        <FormGroup>
          <Label for="name">Name</Label>
          <Input type="text" name="name" id="name" defaultValue={token.name} />
        </FormGroup>
        <h3>Tokens</h3>
        <textarea readOnly value={token.token} />
        <div className="d-flex justify-content-end">
          <Button icon="save" onClick={this.onSave}>Save</Button>
        </div>
      </EditForm>
    );
  }

}
