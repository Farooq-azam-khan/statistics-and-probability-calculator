import React from "react";
import { Row } from "react-bootstrap";

const DisplayDistrbution = props => {
  return (
    <Row
      style={{
        display: "flex",
        backgroundColor: "lightgreen",
        margin: "2rem",
        padding: "1rem",
        textAlign: "center",
        justifyContent: "center"
      }}
    >
      {`${props.randomVariable} ~ ${props.value}(${getDistrbutionParams(
        props.params
      )})`}
    </Row>
  );
};

export default DisplayDistrbution;

const getDistrbutionParams = params => {
  return Object.keys(params).map(p => {
    return `${p}=${params[p]}`;
  });
};
