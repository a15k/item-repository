import { React, action, observer, observable } from './helpers/react';
import { Dropdown, DropdownToggle, DropdownMenu, DropdownItem } from 'reactstrap';
import { Link } from 'react-router-dom';
import Search from './search';
import Button from './button';

@observer
export default class Navbar extends React.Component {

  @observable isDropdownOpen = false;

  @action.bound toggle() {
    this.isDropdownOpen = !this.isDropdownOpen;
  }

  @action.bound onLogout(ev) {
    ev.currentTarget.querySelector('form').submit();
  }

  render() {
    return (
    );
  }

}
