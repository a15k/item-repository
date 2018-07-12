import { UncontrolledTooltip } from 'reactstrap';
import styled from 'styled-components';
import { React } from '../../helpers/react';

const DeletePlaceholderWrapper = styled.div`
min-width: 40px;
min-height: 30px;
`;


const DeletePlaceholder = () => (
  <DeletePlaceholderWrapper id="no-delete-last-power-user">
    <UncontrolledTooltip placement="right" target="no-delete-last-power-user">
      Every membership must have at least one power user
    </UncontrolledTooltip>
  </DeletePlaceholderWrapper>
);

export default DeletePlaceholder;
