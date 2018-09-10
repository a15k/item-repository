import iframeResizer from 'iframe-resizer/js/iframeResizer';
import { React, PropTypes, observer } from '../../helpers/react';
import Format from '../../models/format';

@observer
export default class FormatSpecification extends React.Component {
  static propTypes = {
    format: PropTypes.instanceOf(Format).isRequired,
  }
  componentDidMount() {
    this.iframe = iframeResizer({}, `#format-specification-${this.props.format.id}`)[0];
  }
  componentWillUnmount() {
    if (this.iframe) {
      this.iframe.iFrameResizer.close();
    }
  }
  render() {
    const { format } = this.props;
    return (
      <iframe
        srcDoc={format.specification_document}
        id={`format-specification-${format.id}`}
        src={`/assessment/format/${format.id}`}
        style={{ width: '1px', minWidth: '100%', border: '0px' }}
      />
    );
  }
}
