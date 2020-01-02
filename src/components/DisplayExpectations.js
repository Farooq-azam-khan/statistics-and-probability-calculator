import { Row, Col } from "react-bootstrap";
import React from "react";

const DisplayExpectations = props => {
  return (
    <Row
      style={{
        backgroundColor: "orange",
        margin: "2rem",
        padding: "2rem",
        textAlign: "center",
        color: "black",
        justifyContent: "center"
      }}
    >
      <Col>{`Mean = ${props.mean}`}</Col>
      <Col>{`Var(${props.randomVariable}) = ${props.variance.toFixed(3)}`}</Col>
      <Col>{`Sd(${props.randomVariable}) = ${Math.sqrt(props.variance).toFixed(
        3
      )}`}</Col>
    </Row>
  );
};
export default DisplayExpectations;
