import { React, PropTypes, observer, observable, action } from '../helpers/react';
import { BrowserRouter, Route, Switch, NavLink } from 'react-router-dom';
import { Container, Dropdown, DropdownToggle, DropdownMenu, DropdownItem } from 'reactstrap';
import ReactDOM from 'react-dom';
import styled from 'styled-components';
import whenDomReady from 'when-dom-ready';
import User from '../models/user';
import Config from '../models/config';
import InteractionsApp from '../models/interaction-app';
import Home from '../pages/home';
import Api from '../pages/api';
import Search from '../pages/search';
import NotFound from '../pages/not-found';
import Users from '../pages/users';
import Formats from '../pages/formats';


const MenuLink = ({ to, name }) => (
  <NavLink activeClassName="active" className="dropdown-item" to={to}>
    {name}
  </NavLink>
);
MenuLink.propTypes = {
  to: PropTypes.string.isRequired,
  name: PropTypes.string.isRequired,
};

const Nav = styled.nav`
 margin-bottom: 1rem;
`;

const Title = styled.div.attrs({
  className: 'navbar-brand',
})`
flex: 1;
`;

const Menu = styled(Dropdown)`
 margin-left: 1rem;
`;

@observer
class A15KApplication extends React.Component {

  @observable isUserMenuOpen = false;
  @observable isActionsMenuOpen = false;

  @action.bound onUserMenuToggle() {
    this.isUserMenuOpen = !this.isUserMenuOpen;
  }

  @action.bound onActionsMenuToggle() {
    this.isActionsMenuOpen = !this.isActionsMenuOpen;
  }

  render() {
    return (
      <BrowserRouter>
        <div className="a15k-root">
          <Nav className="navbar navbar-dark bg-dark">
            <Title>Assessment Network</Title>
            {User.isMember &&
              (
                <Menu
                  isOpen={this.isActionsMenuOpen}
                  toggle={this.onActionsMenuToggle}
                >
                  <DropdownToggle caret>
                    Actions
                  </DropdownToggle>
                  <DropdownMenu right
                    onClick={(e) => e.currentTarget.parentElement.click()}
                  >
                    <MenuLink to="/search" name="Search" />
                    {User.isPowerUser && <MenuLink to="/users" name="Users" />}
                    {User.isPowerUser && <MenuLink to="/api" name="Api Access" />}
                    <MenuLink to="/formats" name="Formats" />
                  </DropdownMenu>
                </Menu>
              )}
            <Menu isOpen={this.isUserMenuOpen} toggle={this.onUserMenuToggle}>
              <DropdownToggle caret>
                {User.username || User.name}
              </DropdownToggle>
              <DropdownMenu right>
                {Config.member_name &&
                  [
                    <DropdownItem key="n">Member: {Config.member_name}</DropdownItem>,
                    <DropdownItem key="r">Role: {User.role}</DropdownItem>,
                    <DropdownItem key="d" divider/>,
                  ]}
                <DropdownItem href={Config.openstax_accounts_url}>Profile</DropdownItem>
                <DropdownItem onClick={User.logout}>Logout</DropdownItem>
              </DropdownMenu>
            </Menu>
          </Nav>
          <Container>
            <Switch>
              <Route path="/" exact component={Home} />
              <Route path="/search" component={Search} />
              <Route path="/users" component={Users} />
              <Route path="/formats/:id?" component={Formats} />
              <Route path="/api" component={Api} />
              <Route component={NotFound} />
            </Switch>
          </Container>
          <form id="logout-form" action="/accounts/logout" method="post">
            <input type="hidden" name="authenticity_token" value={Config.csrf_token} />
            <input type="hidden" name="_method" value="delete" />
          </form>
        </div>
      </BrowserRouter>
    );
  }
}

whenDomReady(() => {
  const data = JSON.parse(document.getElementById('bootstrap-data').innerText);
  User.bootstrap(data);
  InteractionsApp.api_url = data.interactions_api_url;
  ReactDOM.render(<A15KApplication />, document.getElementById('application-root'));
});

export default A15KApplication;
