import { withRouter } from 'react-router-dom';
import { ListGroup, ListGroupItem } from 'reactstrap';
import { React, PropTypes, observer, action } from '../helpers/react';
import styled from 'styled-components';
import Format from '../models/format';
import Button from '../components/button';
import ActivityIndicator from '../components/activity-indicator';
import ModelCollection from '../models/model-collection';
import NotFound from './not-found';

const FormatItem = styled(ListGroupItem)`
  display: flex;
  justify-content: space-between;
`;

@withRouter
@observer
export default class Formats extends React.Component {

  static propTypes = {
    collection: PropTypes.instanceOf(ModelCollection),
    match: PropTypes.object.isRequired,
    history: PropTypes.object.isRequired,
  };

  static defaultProps = {
    collection: Format.collection,
  };

  componentDidMount() {
    if (!this.props.collection.api.isFetchedOrFetching) {
      this.props.collection.fetch();
    }
  }

  @action.bound onDisplay(ev) {
    this.props.history.push(`/formats/${ev.currentTarget.dataset.id}`);
  }

  @action.bound onDisplayAll() {
    this.props.history.push('/formats');
  }

  render() {
    const { collection, match: { params: { id } } } = this.props;
    if (collection.api.isPending) {
      return <ActivityIndicator />;
    }

    if (id) {
      const format = collection.get(id);
      if (!format) {
        return <NotFound heading="Format not found" />;
      }
      return (
        <div>
          <h3>
            <Button icon="chevronLeft" onClick={this.onDisplayAll}>Display All</Button>
            {format.name}
          </h3>
          <p>{format.specification}</p>
        </div>
      );
    }
    return (
      <div className="formats-page">
        <ListGroup>
          {collection.array.map(f =>
            <FormatItem key={f.id}>
              <span>{f.name}</span>
              <span>{f.id}</span>
              <Button icon="chevronRight" data-id={f.id} onClick={this.onDisplay} />
            </FormatItem>)}
        </ListGroup>
      </div>
    );
  }
}
