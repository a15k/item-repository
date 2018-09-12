import iframeResizer from 'iframe-resizer/js/iframeResizer';
import { React, PropTypes, observer, computed } from '../../helpers/react';
import Format from '../../models/format';

@observer
export default class FormatSpecification extends React.Component {
  static propTypes = {
    format: PropTypes.instanceOf(Format).isRequired,
  }
  @computed get identifier() {
    return `format-specification-${this.props.format.id}`;
  }
  componentDidMount() {
    this.iframe = iframeResizer({}, '#' + this.identifier)[0];
  }
  componentWillUnmount() {
    if (this.iframe) {
      const { iFrameResizer } = this.iframe;
      setTimeout(() => iFrameResizer.close());
    }
  }
  render() {
    const { format } = this.props;
    return (
      <iframe
        srcDoc={format.specification_document}
        id={this.identifier}
        src={`/assessment/format/${format.id}`}
        style={{ width: '1px', minWidth: '100%', border: '0px' }}
      />
    );
  }
}
