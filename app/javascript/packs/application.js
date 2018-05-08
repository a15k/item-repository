import { React, observer, observable, action } from '../helpers/react';
import { BrowserRouter, Route, Switch, Link, NavLink } from 'react-router-dom';
import { Container, Dropdown, DropdownToggle, DropdownMenu, DropdownItem } from 'reactstrap';
import ReactDOM from 'react-dom';
import whenDomReady from 'when-dom-ready';
import User from '../models/user';
import InteractionsApp from '../models/interaction-app';
import { Home, Search, Interactions, NotFound } from '../pages';

const MenuLink = ({ to, name }) => (
  <NavLink activeClassName="active" className="dropdown-item" to={to}>
    {name}
  </NavLink>
);

@observer
class A15KApplication extends React.Component {

  @observable isMenuOpen = false;

  @action.bound onMenuToggle() {
    this.isMenuOpen = !this.isMenuOpen;
  }

  render() {
    return (
      <BrowserRouter>
        <div className="a15k-root">
          <nav className="navbar navbar-dark bg-dark">
            <Link className="navbar-brand" to="/">Home</Link>
            <Dropdown isOpen={this.isMenuOpen} toggle={this.onMenuToggle}>
              <DropdownToggle caret>
                Dropdown
              </DropdownToggle>
              <DropdownMenu>

                <MenuLink to="/interactions" name="Interactions" />
                <MenuLink to="/search" name="Search" />
                <DropdownItem divider />
                <DropdownItem tag="div" onClick={this.onLogout}>
                  <form path="/accounts/logout">
                    Logout
                  </form>
                </DropdownItem>
              </DropdownMenu>
            </Dropdown>
          </nav>
          <Container>
            <Switch>
              <Route path="/" exact component={Home} />
              <Route path="/search" component={Search} />
              <Route path="/interactions" component={Interactions} />
              <Route component={NotFound} />
            </Switch>
          </Container>
        </div>
      </BrowserRouter>
    );
  };
}

whenDomReady(() => {
  const data = JSON.parse(document.getElementById('bootstrap-data').innerText);
  User.bootstrap(data);
  InteractionsApp.api_url = data.interactions_api_url;
  ReactDOM.render(<A15KApplication />, document.getElementById('application-root'));
});
