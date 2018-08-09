import {
  isString,
} from 'lodash';

export function toSentence(sentence, comma = ', ', nd = ' and ') {
  let words = isString(sentence) ? sentence.split(' ') : sentence;
  if (null == words) { words = []; }
  const last = words.pop();
  if (last) {
    return words.length ? [words.join(comma), last].join(nd) : last;
  }
  return '';
}
