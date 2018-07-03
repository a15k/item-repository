import { React, PropTypes, observer, observable, action, computed } from '../helpers/react';
import {
  InputGroupButtonDropdown, DropdownToggle, DropdownMenu, DropdownItem,
  InputGroup, InputGroupAddon, Button, Input,
} from 'reactstrap';
import AssessmentCollection from './search/collection';
import styled from 'styled-components';
import ModelErrors from '../components/model-errors';

const PreviewWrapper = styled.div`
margin-top: 1rem;
`;
const Preview = ({ assessment }) => {
  const html = { __html: assessment.preview_html };
  return <PreviewWrapper dangerouslySetInnerHTML={html} />
};

@observer
export default class Search extends React.Component {

  static propTypes = {
    collection: PropTypes.instanceOf(AssessmentCollection),
  };

  @observable collection = this.props.collection || new AssessmentCollection();
  @observable isDropdownOpen = false;
  @observable searchingBy = 'Text'

  @action.bound onDropdownToggle() {
    this.isDropdownOpen = !this.isDropdownOpen;
  }

  @action.bound onSearchClick() {
    if ('ID' == this.searchingBy) {
      this.collection.fetchById(this.inputRef.value);
    } else {
      this.collection.search(this.inputRef.value);
    }
  }

  @action.bound detectEnterPress(ev) {
    if ('Enter' === ev.key) { this.onSearchClick(); }
  }

  @action.bound setInputRef(input) { this.inputRef = input; }

  @action.bound onSearchTypeChange(ev) {
    this.searchingBy = ev.target.dataset.type;
    this.inputRef.focus();
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
              Search by {this.searchingBy}
            </DropdownToggle>

            <DropdownMenu>
              <DropdownItem
                data-type="ID"
                onClick={this.onSearchTypeChange}
              >
                ID
              </DropdownItem>

              <DropdownItem
                data-type="Text"
                onClick={this.onSearchTypeChange}
              >
                Text
              </DropdownItem>
            </DropdownMenu>

          </InputGroupButtonDropdown>
          <Input type="text" innerRef={this.setInputRef} onKeyPress={this.detectEnterPress} />
          <InputGroupAddon addonType="append">
            <Button onClick={this.onSearchClick} color="secondary">Search</Button>
          </InputGroupAddon>
        </InputGroup>
        <ModelErrors model={this.assessment} />
        {this.collection.map(a => <Preview key={a.id} assessment={a} />)}
      </div>
    );
  }

}
