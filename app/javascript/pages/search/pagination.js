import { React, PropTypes, observer, action } from '../../helpers/react';
import styled from 'styled-components';
import ReactPaginate from 'react-paginate';
import AssessmentsCollection from './collection';

// https://github.com/AdeleD/react-paginate/issues/220
const PaginationWrapper = styled.div`

  display: flex;
  margin-top: 2rem;

  ul {
    flex: 1;
    display: flex;
    padding-left: 0;
  }
  li {
    min-width: 40px;
    min-height: 40px;
    display: flex;
    align-items: center;
    justify-content: center;
    border: 1px solid #ddd;
    border-width: 1px 1px 1px 0;
  }
  li > a,
  li > span {
    position: relative;
    flex: 1;
    text-decoration: none;
    color: #2c689c;
    background-color: #fff;
    align-self: stretch;
    display: flex;
    align-items: center;
    justify-content: center;
    cursor: pointer;
  }
  li.break {
    align-items: flex-start;
  }
  li:first-child {
    border-left-width: 1px;
    border-bottom-left-radius: 4px;
    border-top-left-radius: 4px;
    min-width: 80px;
  }

  li:last-child {
    border-bottom-right-radius: 4px;
    border-top-right-radius: 4px;
    min-width: 80px;
  }
  li > a:hover,
  li > span:hover,
  li > a:focus,
  li > span:focus {
    z-index: 2;
    color: #1b4060;
    background-color: #eeeeee;
    border-color: #ddd;
  }
  .active > a,
  .active > span,
  .active > a:hover,
  .active > span:hover,
  .active > a:focus,
  .active > span:focus {
    z-index: 3;
    color: #fff;
    background-color: #2c689c;
    border-color: #2c689c;
    cursor: default;
  }
  .disabled > span,
  .disabled > span:hover,
  .disabled > span:focus,
  .disabled > a,
  .disabled > a:hover,
  .disabled > a:focus {
    color: #777777;
    background-color: #fff;
    border-color: #ddd;
    cursor: not-allowed;
  }
`;

@observer
export default class Pagination extends React.Component {

  static propTypes = {
    assessments: PropTypes.instanceOf(AssessmentsCollection).isRequired,
    onChange: PropTypes.func.isRequired,
  }

  @action.bound handlePageClick({ selected }) {
    this.props.onChange({ page: selected + 1 });
  }

  render() {
    const { assessments } = this.props;

    return (
      <PaginationWrapper>
        <ReactPaginate
          pageCount={assessments.pageCount}
          forcePage={assessments.page - 1}
          marginPagesDisplayed={2}
          pageRangeDisplayed={5}
          onPageChange={this.handlePageClick}
          activeClassName="active"
        />
      </PaginationWrapper>
    );
  }

}
