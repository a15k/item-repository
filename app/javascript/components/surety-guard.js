import { React, action, observable, observer } from '../helpers/react';
import ReactDOM from 'react-dom';
import PropTypes from 'prop-types';
import { Popover, Button, PopoverHeader, PopoverBody } from 'reactstrap';
import { defer } from 'lodash';
import styled from 'styled-components';

const Controls = styled.div`
display: flex;
min-width: 200px;
justify-content: space-around;
padding: 0.5rem 0.75rem;
`;

@observer
export default class SuretyGuard extends React.Component {

  static propTypes = {
    children:          PropTypes.node.isRequired,
    onConfirm:         PropTypes.func.isRequired,
    message:           PropTypes.node.isRequired,
    header:            PropTypes.node,
    placement:         PropTypes.string,
    okButtonLabel:     PropTypes.string,
    cancelButtonLabel: PropTypes.string,
    onlyPromptIf:      PropTypes.func,
    tabIndex:          PropTypes.string,
  };

  static defaultProps = {
    header:             'Are you sure?',
    placement:         'top',
    okButtonLabel:     'OK',
    tabIndex:          '0',
    cancelButtonLabel: 'Cancel',
  };

  @observable isShowing = false;
  @observable node;

  @action.bound onConfirm(ev) {
    this.isShowing = false;
    return this.props.onConfirm(ev);
  }

  @action.bound onCancel() {
    this.isShowing = false;
  }

  @action.bound getTarget() {
    return this.node;
  }

  @action.bound show() {
    this.isShowing = true;
  }

  @action.bound setTargetRef(e) {
    this.node = e;
  }

  render() {
    const {
      children, header, message, cancelButtonLabel,
      okButtonLabel, tabIndex,
    } = this.props;

    return (
      <span
        role="button"
        tabIndex={tabIndex}
        ref={this.setTargetRef}
        onClick={this.show}
      >
        <Popover
          target={this.getTarget}
          isOpen={this.isShowing}
        >
          {header && <PopoverHeader>{header}</PopoverHeader>}
          <PopoverBody>
            {message}

          </PopoverBody>
          <Controls>
            <Button onClick={this.onCancel}>
              {cancelButtonLabel}
            </Button>
            <Button color="primary" onClick={this.onConfirm}>
              {okButtonLabel}
            </Button>
          </Controls>
        </Popover>
        {children}
      </span>
    );
  }
}
