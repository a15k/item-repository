import { React, PropTypes } from '../helpers/react';

export default function NotFound({ heading = 'Not Found' }) {
  return (
    <h3>{heading}</h3>
  );
}

NotFound.propTypes = {
  heading: PropTypes.string,
};
