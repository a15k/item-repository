import { React, observer, observable, action } from '../helpers/react';
import { BrowserRouter, Route, Switch, Link, NavLink } from 'react-router-dom';
import { Container, Dropdown, DropdownToggle, DropdownMenu, DropdownItem } from 'reactstrap';
import ReactDOM from 'react-dom';
import whenDomReady from 'when-dom-ready';
import User from '../models/user';
import InteractionsApp from '../models/interaction-app';
import * as Pages from '../pages';

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

  @action.bound onLogout(ev) {
    ev.currentTarget.querySelector('form').submit();
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
                <MenuLink to="/tokens" name="Tokens" />
                <DropdownItem divider />
                <DropdownItem tag="div" onClick={this.onLogout}>
                  <form action="/accounts/logout" method="post">
                    Logout
                  </form>
                </DropdownItem>
              </DropdownMenu>
            </Dropdown>
          </nav>
          <Container>
            <Switch>
              <Route path="/" exact component={Pages.Home} />
              <Route path="/search" component={Pages.Search} />
              <Route path="/tokens" component={Pages.Tokens} />
              <Route path="/interactions" component={Pages.Interactions} />
              <Route component={Pages.NotFound} />
            </Switch>
          </Container>
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
