import React from "react";
import { Row } from "react-bootstrap";

const DisplayProbability = props => {
  return (
    <Row>
      {`P(${props.randomVariable} ${props.value ? props.value : "Operation?"} ${
        props.upper
      }) = ${props.output.toFixed(3)}`}
    </Row>
  );
};

export default DisplayProbability;
