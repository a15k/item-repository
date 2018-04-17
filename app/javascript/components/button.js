import { React } from '../helpers/react';
import { Button as BSButton } from 'reactstrap';
import PropTypes from 'prop-types';
import styled from 'styled-components';
import Icon from './icon';

const StyledButton = styled(BSButton)`
.icon + span { margin-left: 0.5rem; }
`;

export default function Button({ icon, children, ...props }) {
  const text = children && <span>{children}</span>;

  return (
    <StyledButton {...props}>
      {icon && <Icon icon={icon} />}
      {text}
    </StyledButton>
  );

}
