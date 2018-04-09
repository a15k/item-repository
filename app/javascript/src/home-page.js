import { React, action, observer } from './helpers/react';
import { Container, Row, Col } from 'reactstrap';
import Search from './search';
import Button from './button';

@observer
export default class HomePage extends React.Component {

  render() {
    return (
      <div>
        <nav className="navbar navbar-dark bg-dark">
          <span className="navbar-brand mb-0 h1">Home</span>
          <form path="/accounts/logout">
            <button className="btn btn-secondary" type="submit">Logout</button>
          </form>
        </nav>
        <Container>
          <Search />
        </Container>
      </div>
    );
  }

}
