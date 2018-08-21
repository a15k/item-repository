import { React, PropTypes } from '../helpers/react';
import FontAwesomeIcon from '@fortawesome/react-fontawesome';
import invariant from 'invariant';
import cn from 'classnames';

import signIn from '@fortawesome/fontawesome-free-solid/faSignInAlt';
import signOut from '@fortawesome/fontawesome-free-solid/faSignOutAlt';
import plus from '@fortawesome/fontawesome-free-solid/faPlus';
import trash from '@fortawesome/fontawesome-free-solid/faTrashAlt';
import envelope from '@fortawesome/fontawesome-free-solid/faEnvelope';
import chevronRight from '@fortawesome/fontawesome-free-solid/faChevronRight';
import chevronLeft from '@fortawesome/fontawesome-free-solid/faChevronLeft';
import save from '@fortawesome/fontawesome-free-solid/faSave';
import spinner from '@fortawesome/fontawesome-free-solid/faSpinner';

const ICONS = {
  signIn,
  signOut,
  plus,
  trash,
  envelope,
  chevronRight,
  chevronLeft,
  save,
  spinner,
};

export default function Icon({ icon, className, ...props }) {
  invariant(ICONS[icon], `${icon} has not been imported`);
  return (
    <FontAwesomeIcon
      className={cn('icon', className)}
      icon={ICONS[icon]}
      {...props}
    />
  );
}

Icon.propTypes = {
  icon: PropTypes.string.isRequired,
  className: PropTypes.string,
};
