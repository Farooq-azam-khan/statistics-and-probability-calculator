import React from "react";
import "./App.css";
import Distribution from "./components/Distributions";
import "bootstrap/dist/css/bootstrap.min.css";
import Container from "react-bootstrap/Container";

function App() {
  return (
    <div className="App">
      <Container>
        <Distribution />
      </Container>
    </div>
  );
}

export default App;
