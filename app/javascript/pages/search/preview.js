import styled from 'styled-components';
import { NavLink } from 'react-router-dom';
import { React, PropTypes, action, observer, computed } from '../../helpers/react';
import iframeResizer from 'iframe-resizer/js/iframeResizer';
import { Badge } from 'reactstrap';
import { get } from 'lodash';
import ModelCollection from '../../models/model-collection';
import Assessment from '../../models/assessment';
import Button from '../../components/button';
import { saveAs } from 'file-saver/FileSaver';

@observer
class Iframe extends React.Component {
  static propTypes = {
    assessment: PropTypes.instanceOf(Assessment).isRequired,
  }
  @computed get identifier() {
    return `preview-${this.props.assessment.id}`;
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
    const { assessment } = this.props;
    return (
      <iframe
        srcDoc={assessment.preview_document}
        id={this.identifier}
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
margin-top: 0.5rem;
`;

const Tags = styled.div`
display: flex;
flex-wrap: wrap;
justify-content: flex-end;
`;

const Tag = styled(Badge)`
  margin-left: 0.3rem;
  margin-top: 0.3rem;
`;

@observer
class Download extends React.Component {
  static propTypes = {
    assessment: PropTypes.instanceOf(Assessment).isRequired,
  }

  @action.bound onClick() {
    const { assessment } = this.props;
    const fileName = `${assessment.id}.json`;
    const fileToSave = new Blob([JSON.stringify(assessment.raw)], {
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
      <Tags>
        {assessment.tags.map(t => <Tag key={t} color="info">{t}</Tag>)}
      </Tags>
      <Info>
        <InfoBit>Member: {get(assessment.member, 'name')}</InfoBit>
        <InfoBit>ID: {assessment.a15k_identifier}</InfoBit>
        <InfoBit>Version: {assessment.a15k_version}</InfoBit>
        <InfoBit>
          <NavLink to={`/formats/${assessment.format_id}`}>
            Format: {get(formats.get(assessment.format_id), 'name')}
          </NavLink>
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
