import { React, PropTypes } from '../helpers/react';
import styled from 'styled-components';
import Icon from './icon';

const Indicator = styled.div`
display: flex;
align-items: center;
.icon + span { margin-left: 0.5rem; }
`;


export default function ActivityIndicator({
  icon = 'spinner',
  label = 'Loading…',
}) {
  return (
    <Indicator>
      {icon && <Icon icon={icon} spin />}
      <span>{label}</span>
    </Indicator>
  );
}

ActivityIndicator.propTypes = {
  icon: PropTypes.string,
  label: PropTypes.string,
};
