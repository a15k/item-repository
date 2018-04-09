import { React } from './helpers/react';
import FontAwesomeIcon from '@fortawesome/react-fontawesome';
import invariant from 'invariant';
import cn from 'classnames';

import signIn from '@fortawesome/fontawesome-free-solid/faSignInAlt';
import signOut from '@fortawesome/fontawesome-free-solid/faSignOutAlt';
const ICONS = {
  signIn,
  signOut,
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
