import { React } from './helpers/react';
import { Button as BSButton } from 'reactstrap';
import PropTypes from 'prop-types';
import styled from 'styled-components';
import Icon from './icon';

const StyledButton = styled(BSButton)`
.icon { margin-right: 0.5rem; }
`;

export default function Button({ icon, children, ...props }) {

  return (
    <StyledButton {...props}>
      {icon && <Icon icon={icon} />}
      {children}
    </StyledButton>
  );

}
