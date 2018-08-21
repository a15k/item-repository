import styled from 'styled-components';
import { NavLink } from 'react-router-dom';
import { React, PropTypes, action, observer } from '../../helpers/react';
import { Badge } from 'reactstrap';
import { get } from 'lodash';
import ModelCollection from '../../models/model-collection';
import Assessment from '../../models/assessment';
import Button from '../../components/button';
import { saveAs } from 'file-saver/FileSaver';

const RightButton = styled(Button)`
float:right;
margin: 0 0 1rem 1rem;
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
  const html = { __html: assessment.preview_html };
  return (
    <PreviewWrapper>
      <Download assessment={assessment} />

      <div dangerouslySetInnerHTML={html} />

      <Info>
        <InfoBit>Member: {get(assessment.member, 'name')}</InfoBit>
        <InfoBit>ID: {assessment.id}</InfoBit>
        <InfoBit>Version: {assessment.version}</InfoBit>
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
