import styled from 'styled-components';
import { NavLink } from 'react-router-dom';
import { React, PropTypes, action, observer } from '../../helpers/react';
import iframeResizer from 'iframe-resizer/js/iframeResizer';
import { Badge } from 'reactstrap';
import { get } from 'lodash';
import ModelCollection from '../../models/model-collection';
import Assessment from '../../models/assessment';
import Button from '../../components/button';
import { saveAs } from 'file-saver/FileSaver';

class Iframe extends React.Component {
  static propTypes = {
    assessment: PropTypes.instanceOf(Assessment).isRequired,
  }
  componentDidMount() {
    this.iframe = iframeResizer({}, `#preview-${this.props.assessment.id}`)[0];
  }
  componentWillUnmount() {
    if (this.iframe) {
      this.iframe.iFrameResizer.close();
    }
  }
  render() {
    const { assessment } = this.props;
    return (
      <iframe
        srcDoc={assessment.preview_document}
        id={`preview-${assessment.id}`}
        src={`/assessment/preview/${assessment.id}`}
        style={{ width: '1px', minWidth: '100%', border: '0px' }}
      />
    );
  }
}


const RightButton = styled(Button)`
margin: 0.5rem 0;
float: right;
`;

const InfoBit = styled.div`
color: #49a0b5;
display: flex;
align-items: center;
justify-content: center;
& + & {
  margin-left: 0.5rem;
  padding-left: 0.5rem;
  border-left: 1px solid #acdbd8;
}
`;

const PreviewWrapper = styled.div`
margin-top: 1rem;
padding-top: 1rem;
border-top: 1px solid grey;
`;

const Info = styled.div`
display: flex;
justify-content: flex-end;
`;

const Tag = styled(Badge)`
& + & { margin-left: 0.3rem; }
`;

@observer
class Download extends React.Component {
  static propTypes = {
    assessment: PropTypes.instanceOf(Assessment).isRequired,
  }

  @action.bound onClick() {
    const { assessment } = this.props;
    const fileName = `${assessment.id}.json`;
    const fileToSave = new Blob([JSON.stringify(assessment.serialize())], {
      type: 'application/json',
      name: fileName,
    });
    saveAs(fileToSave, fileName);
  }

  render() {
    return (
      <RightButton size="sm" onClick={this.onClick}>
        Download
      </RightButton>
    );
  }
}

const Preview = ({ assessment, formats }) => {
  return (
    <PreviewWrapper>
      <Download assessment={assessment} />
      <Iframe assessment={assessment} />
      <Info>
        <InfoBit>Member: {get(assessment.member, 'name')}</InfoBit>
        <InfoBit>ID: {assessment.a15k_identifier}</InfoBit>
        <InfoBit>Version: {assessment.a15k_version}</InfoBit>
        <InfoBit>
          <NavLink to={`/formats/${assessment.format_id}`}>
            Format: {get(formats.get(assessment.format_id), 'name')}
          </NavLink>
        </InfoBit>
        <InfoBit>
          {assessment.tags.map(t => <Tag key={t} color="info">{t}</Tag>)}
        </InfoBit>
      </Info>

    </PreviewWrapper>
  );
};

Preview.propTypes = {
  assessment: PropTypes.instanceOf(Assessment).isRequired,
  formats: PropTypes.instanceOf(ModelCollection).isRequired,
};

export default Preview;
