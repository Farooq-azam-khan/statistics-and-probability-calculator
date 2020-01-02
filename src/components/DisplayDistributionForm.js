import { Row, Col } from "react-bootstrap";
import React from "react";
import PropTypes from "prop-types";
import Select from "react-select";

import operationOptions from "./OperationOptions";
import distributionOptions from "./DisplayDistribution";

const DisplayDistrbutionForm = props => {
  return (
    <Row>
      <Col xs="2">
        <label htmlFor="rand-var">Random Variable:</label>
        <input
          className="form-control"
          id="rand-var"
          type="text"
          value={props.randomVariable}
          onChange={props.handleRandomVar}
        />
      </Col>
      <Col xs="4">
        <label htmlFor="select-op">Select Value: </label>
        <Select
          id="select-op"
          value={props.operation}
          onChange={props.handleOperation}
          options={operationOptions}
        />
      </Col>
      <Col xs="4">
        <label htmlFor="select-dist">Select Distribution: </label>
        <Select
          id="select-dist"
          value={props.distribution}
          onChange={props.handleDistribution}
          options={distributionOptions}
        />
      </Col>
      <Col xs="2">
        <label htmlFor="upper-bound-value">Upper value:</label>
        <input
          className="form-control"
          id="upper-bound-value"
          type="number"
          value={props.upper}
          onChange={props.handleUpper}
        />
      </Col>
    </Row>
  );
};

DisplayDistrbutionForm.propTypes = {
  randomVariable: PropTypes.string,
  handleRandomVar: PropTypes.func,
  operation: PropTypes.object,
  handleOperation: PropTypes.func,
  distribution: PropTypes.object,
  handleDistribution: PropTypes.func,
  upper: PropTypes.number,
  handleUpper: PropTypes.func
};

export default DisplayDistrbutionForm;
