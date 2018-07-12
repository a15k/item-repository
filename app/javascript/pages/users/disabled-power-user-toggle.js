import { UncontrolledTooltip } from 'reactstrap';
import { React } from '../../helpers/react';

import CheckBox from './checkbox';

const DisabledPowerUserToggle = () => (
  <span id="no-downgrade-last-power-user">
    <CheckBox checked={true} readOnly={true} />
    <UncontrolledTooltip placement="right" target="no-downgrade-last-power-user">
      Every membership must have at least one power user
    </UncontrolledTooltip>
  </span>
);

export default DisabledPowerUserToggle;
