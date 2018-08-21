import { React, PropTypes, observer, observable, action } from '../helpers/react';
import {
  InputGroupButtonDropdown, DropdownToggle, DropdownMenu, DropdownItem,
  InputGroup, InputGroupAddon, Button, Input, FormText,
} from 'reactstrap';
import ModelCollection from '../models/model-collection';
import AssessmentCollection from './search/collection';
import Format from '../models/format';
import ModelErrors from '../components/model-errors';
import Preview from './search/preview';

const HELP = {
  Text: 'Enter text to search for.  Assessment metadata is searched first and then statisistics',
  ID: 'Enter assessment identifier to search for',
};

const SearchHelp = ({ type, results }) => (
  results.assessments.length == 0 && <FormText color="muted">{HELP[type]}</FormText>
);

@observer
export default class Search extends React.Component {

  static propTypes = {
    collection: PropTypes.instanceOf(AssessmentCollection),
    formats: PropTypes.instanceOf(ModelCollection),
  };

  static defaultProps = {
    formats: Format.collection,
  };

  @observable collection = this.props.collection || new AssessmentCollection();
  @observable isDropdownOpen = false;
  @observable searchingBy = 'Text'

  componentDidMount() {
    if (!this.props.formats.api.isFetchedOrFetching) {
      this.props.formats.fetch();
    }
  }

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
    const { formats } = this.props;

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
        <SearchHelp type={this.searchingBy} results={this.collection} />
        <ModelErrors model={this.assessment} />
        {this.collection.map(a => <Preview key={a.id} formats={formats} assessment={a} />)}
      </div>
    );
  }

}
