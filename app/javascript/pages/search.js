import { React, observer, observable, action, computed } from '../helpers/react';
import {
  InputGroupButtonDropdown, DropdownToggle, DropdownMenu, DropdownItem,
  InputGroup, InputGroupAddon, Button, Input,
} from 'reactstrap';
import styled from 'styled-components';
import Assessment from '../models/assessment';
import ModelErrors from '../components/model-errors';

const Preview = styled.div`
margin-top: 1rem;
`;

@observer
export default class Search extends React.Component {

  @observable isDropdownOpen = false;
  @observable assessment = new Assessment();

  @action.bound onDropdownToggle() {
    this.isDropdownOpen = !this.isDropdownOpen;
  }

  @action.bound onSearchClick() {
    Assessment.fetch({ id: this.inputRef.value })
      .then((assessment) => {
        this.assessment = assessment;
      });
  }

  @action.bound detectEnterPress(ev) {
    if ('Enter' === ev.key) { this.onSearchClick(); }
  }

  @action.bound setInputRef(input) { this.inputRef = input; }

  @computed get previewHTML() {
    return { __html: this.assessment.preview_html };
  }
  render() {

    return (
      <div className="search-page">
        <InputGroup>
          <InputGroupButtonDropdown
            addonType="prepend"
            isOpen={this.isDropdownOpen}
            toggle={this.onDropdownToggle}
          >
            <DropdownToggle caret>
              Search by ID
            </DropdownToggle>

            <DropdownMenu>
              <DropdownItem header>Header</DropdownItem>
              <DropdownItem disabled>Action</DropdownItem>
              <DropdownItem>Another Action</DropdownItem>
              <DropdownItem divider />
              <DropdownItem>Another Action</DropdownItem>
            </DropdownMenu>

          </InputGroupButtonDropdown>
          <Input type="text" innerRef={this.setInputRef} onKeyPress={this.detectEnterPress} />
          <InputGroupAddon addonType="append">
            <Button onClick={this.onSearchClick} color="secondary">Search</Button>
          </InputGroupAddon>
        </InputGroup>
        <ModelErrors model={this.assessment} />
        <Preview dangerouslySetInnerHTML={this.previewHTML} />
      </div>
    );
  }

}
