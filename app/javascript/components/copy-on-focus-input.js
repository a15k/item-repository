import { React, PropTypes, observer, observable, action, cn } from '../helpers/react';
import Clipboard from '../helpers/clipboard';
import { uniqueId } from 'lodash';

@observer
export default class CopyOnFocusInput extends React.Component {

  static propTypes = {
    value: PropTypes.string,
    label: PropTypes.string,
    className: PropTypes.string,
    focusOnMount: PropTypes.bool,
    onFocus: PropTypes.func,
  }

  @observable input;

  inputId = uniqueId('copy-on-focus-input');

  static defaultProps = {
    focusOnMount: false,
  }

  focus() {
    this.input.focus();
  }

  @action.bound onFocus() {
    this.input.select();
    Clipboard.copy();
    const { onFocus } = this.props;
    if (onFocus) { onFocus(this); }
  }

  @action.bound setInput(i) { this.input = i; }

  componentDidMount() {
    if (this.props.focusOnMount) {
      this.focus();
      this.input.select();
      const { onFocus } = this.props;
      if (onFocus) { onFocus(this); }
    }
  }

  render() {
    const { label, className, focusOnMount: _, ...inputProps } = this.props;

    const input = (
      <input
        className={cn('copy-on-focus', className, 'form-control')}
        ref={this.setInput}
        readOnly={true}
        id={this.inputId}
        onFocus={this.onFocus}
        {...inputProps} />
    );

    if (label) {
      return (
        <React.Fragment>
          <label className={className} htmlFor={this.inputId}>{label}</label>
          {input}
        </React.Fragment>
      );
    }

    return input;
  }
}
