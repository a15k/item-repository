import { readonly } from 'core-decorators';

const Clipbard = {

  @readonly isSupported: (
    'function' === typeof document.queryCommandSupported ?
      document.queryCommandSupported('copy') : false
  ),

  copy() {
    if (!this.isSupported) { return; }

    try {
      document.execCommand('copy');
    } catch (error) {
      // eslint-disable-next-line no-console
      console.warn('clipboard copy failed', error);
    }
  },

};

export default Clipbard;
