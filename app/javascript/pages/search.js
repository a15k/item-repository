import { React, PropTypes, observer, observable, action } from '../helpers/react';
import {
  InputGroup, InputGroupAddon, Button, Input, FormText,
} from 'reactstrap';
import qs from 'query-string';
import { withRouter } from 'react-router-dom';
import ModelCollection from '../models/model-collection';
import AssessmentCollection from './search/collection';
import Format from '../models/format';
import ModelErrors from '../components/model-errors';
import Pagination from './search/pagination';
import Results from './search/results';

const HELP = {
  Text: 'Enter text to search for.  Assessment metadata is searched first and then statisistics',
  ID: 'Enter assessment identifier to search for',
};

const SearchHelp = ({ type, results }) => (
  results.isEmpty && <FormText color="muted">{HELP[type]}</FormText>
);

@observer
export class Search extends React.Component {

  static defaultProps = {
    formats: Format.collection,
  };

  static propTypes = {
    collection: PropTypes.instanceOf(AssessmentCollection),
    formats: PropTypes.instanceOf(ModelCollection),
    query: PropTypes.string,
    page: PropTypes.string,
    offset: PropTypes.string,
    updateSearch: PropTypes.func.isRequired,
  };

  @observable collection = this.props.collection || new AssessmentCollection();
  @observable isDropdownOpen = false;

  @action.bound updateSearch(search) {
    this.collection.update(search);
    this.props.updateSearch(this.collection.queryParams);
  }

  componentDidMount() {
    const { formats, query } = this.props;
    if (!formats.api.isFetchedOrFetching) {
      formats.fetch();
    }
    if (query) {
      this.collection.update(this.props);
    }
  }

  @action.bound onDropdownToggle() {
    this.isDropdownOpen = !this.isDropdownOpen;
  }

  @action.bound onSearchClick() {
    this.updateSearch({
      page: 1, query: this.inputRef.value,
    });
  }

  @action.bound detectEnterPress(ev) {
    if ('Enter' === ev.key) { this.onSearchClick(); }
  }

  @action.bound setInputRef(input) { this.inputRef = input; }

  render() {
    const { formats, query } = this.props;

    return (
      <div className="search-page">
        <InputGroup>
          <Input defaultValue={query} type="text" innerRef={this.setInputRef} onKeyPress={this.detectEnterPress} />
          <InputGroupAddon addonType="append">
            <Button onClick={this.onSearchClick} color="secondary">Search</Button>
          </InputGroupAddon>
        </InputGroup>
        <SearchHelp type={this.searchingBy} results={this.collection} />
        <ModelErrors model={this.assessment} />
        <Pagination onChange={this.updateSearch} assessments={this.collection} />
        <Results
          key={this.collection.queryParams}
          assessments={this.collection} formats={formats}
        />
      </div>
    );
  }

}


@observer
@withRouter
export default class SearchFromURL extends React.Component {

  static propTypes = {
    location: PropTypes.object.isRequired,
    history: PropTypes.object.isRequired,
  };

  @action.bound updateSearch(search) {
    this.props.history.push({
      pathname: this.props.location.pathname,
      search,
    });
  }

  render() {
    const { search } = this.props.location;
    const props = qs.parse(search);
    return <Search updateSearch={this.updateSearch} { ...props } />;
  }

}
