import React from "react";
import "./App.css";
import Distribution from "./components/Distributions";
import "bootstrap/dist/css/bootstrap.min.css";
import Container from "react-bootstrap/Container";
import { Nav, Navbar } from "react-bootstrap";
import { BrowserRouter as Router, Switch, Route, Link } from "react-router-dom";
import DistributionList from "./components/DistributionList";
function App() {
  return (
    <div className="App">
      <Router>
        <Navbar bg="light" expand="lg">
          <Navbar.Brand href="#home">StatsPKG</Navbar.Brand>
          <Navbar.Toggle aria-controls="basic-navbar-nav" />
          <Navbar.Collapse id="basic-navbar-nav">
            <Nav className="mr-auto ml-auto">
              <li className={"nav-link"}>
                <Link to="/">Home</Link>
              </li>
              <li className={"nav-link"}>
                <Link to="/distributions">Distribution</Link>
              </li>
            </Nav>
          </Navbar.Collapse>
        </Navbar>
        <div className={"mt-4 mb-4"}>
          <Container>
            <Switch>
              <Route exact path="/">
                <Distribution />
              </Route>
              <Route path="/distributions">
                <DistributionList />
              </Route>
            </Switch>
          </Container>
        </div>
      </Router>
    </div>
  );
}

export default App;
