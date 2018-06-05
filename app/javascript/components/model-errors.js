import { React } from '../helpers/react';
import { Alert } from 'reactstrap';
import { isEmpty, isString, trim, capitalize, map } from 'lodash';
import styled from 'styled-components';

const ErrorWrapper = styled.div`
  margin: 1rem 0;
`;

function underscored(str) {
  return trim(str)
    .replace(/([a-z\d])([A-Z]+)/g, '$1_$2')
    .replace(/[-\s]+/g, '_')
    .toLowerCase();
}

function humanize(str) {
  return capitalize(trim(underscored(str)
    .replace(/_id$/, '')
    .replace(/_/g, ' ')));
}

function toSentence(sentence, comma = ', ', nd = ' and ') {
  let words = isString(sentence) ? sentence.split(' ') : sentence;
  if (null == words) { words = []; }
  const last = words.pop();
  if (last) {
    return words.length ? [words.join(comma), last].join(nd) : last;
  }
  return '';
}

export default function ModelErrors({ model, errors, className }) {
  if (model && isEmpty(errors)) { errors = model.errors; }
  if (isEmpty(errors)) return null;

  const msg = toSentence(
    map(errors, (v, k) => (
      'base' === k ? v : `${humanize(k)} ${v}`
    )),
  );

  return (
    <ErrorWrapper>
      <Alert className={className} color="danger">{msg}</Alert>
    </ErrorWrapper>
  );
}
