import { React, PropTypes, observer } from '../../helpers/react';
import ModelCollection from '../../models/model-collection';
import AssessmentsCollection from './collection';
import Preview from './preview';

@observer
export default class SearchResults extends React.Component {

  static propTypes = {
    assessments: PropTypes.instanceOf(AssessmentsCollection).isRequired,
    formats: PropTypes.instanceOf(ModelCollection),
  }

  componentDidMount() {
    this.props.assessments.fetch();
  }

  render() {
    const { assessments, formats } = this.props;
    if (assessments.api.isPending) { return null; }
    return (
      <div className="search-results">
        {assessments.map(a => <Preview key={a.id} formats={formats} assessment={a} />)}
      </div>
    );
  }

}
