import { React, PropTypes } from '../helpers/react';
import { Button as BSButton } from 'reactstrap';
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

Button.propTypes = {
  icon: PropTypes.string,
  children: PropTypes.node,
};
