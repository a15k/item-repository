import styled from 'styled-components';
import { NavLink } from 'react-router-dom';
import { React, PropTypes } from '../../helpers/react';
import { Badge } from 'reactstrap';
import { get } from 'lodash';
import ModelCollection from '../../models/model-collection';

const PreviewWrapper = styled.div`
margin-top: 1rem;
padding-top: 1rem;
border-top: 1px solid grey;
`;

const Tags = styled.div`
display: flex;
justify-content: flex-end;
> * { margin-left: 0.3rem; }
`;

const Preview = ({ assessment, formats }) => {
  const html = { __html: assessment.preview_html };
  return (
    <PreviewWrapper>
      <div dangerouslySetInnerHTML={html} />
      <Tags>
        <NavLink className="badge badge-dark" to={`/formats/${assessment.format_id}`}>
          Format: {get(formats.get(assessment.format_id), 'name')}
        </NavLink>
        {assessment.tags.map(t => <Badge key={t} color="info">{t}</Badge>)}
      </Tags>

    </PreviewWrapper>
  );
};

Preview.propTypes = {
  assessment: PropTypes.shape({ preview_html: PropTypes.string }).isRequired,
  formats: PropTypes.instanceOf(ModelCollection).isRequired,
};

export default Preview;
