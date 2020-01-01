import React from "react";
import Select from "react-select";
import { Row, Col } from "react-bootstrap";
import operationOptions from "./OperationOptions";
import distributionOptions from "./DistrbutionOptions";
import DistributionParam from "./DistributionParam";

export default class Distributions extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      randomVariable: "X",
      lower: 0,
      upper: 8,
      operation: operationOptions[0],
      distribution: distributionOptions[0],
      mean: 0,
      variance: 0,
      output: 0,
      params: {}
    };
  }

  componentDidMount() {
    this.handleDistribution(this.state.distribution);
  }

  calculateProbability = () => {
    let sumIt = 0;

    const distrbFunc = this.state.distribution.func(this.state.params);
    if (this.state.distribution.discrete) {
      if (this.state.operation.value === "<=") {
        for (let x = 0; x <= this.state.upper; x++) {
          const p_of_x = distrbFunc.prob(x);
          sumIt += p_of_x;
        }
      } else {
        for (let x = 0; x < this.state.upper; x++) {
          sumIt += distrbFunc.prob(x);
        }
      }

      this.setState({ output: sumIt });
    } else {
    }

    this.setState({ mean: distrbFunc.mean, variance: distrbFunc.var });
  };

  handleLower = e => {
    this.setState({ lower: e.target.value }, () => {
      this.calculateProbability();
    });
  };

  handleUpper = e => {
    this.setState({ upper: e.target.value }, () => {
      this.calculateProbability();
    });
  };

  handleOperation = operation => {
    this.setState({ operation }, () => {
      this.calculateProbability();
    });
  };

  handleRandomVar = e => {
    this.setState({ randomVariable: e.target.value });
  };

  handleDistribution = distribution => {
    this.setState({ distribution, params: { ...distribution.params } }, () => {
      this.calculateProbability();
    });
  };

  applyDistFunction = () => {
    const newDist = { ...this.state.distribution };
    const currentState = this.state;
    currentState.mean = newDist.func(this.state.params).mean;
    currentState.variance = newDist.func(this.state.params).variance;
    this.setState(currentState);
    console.log(this.state);
  };

  handleParamsChange = e => {
    const targetId = e.target.id;
    const newParams = { ...this.state.params };
    newParams[targetId] = e.target.value;
    this.setState({ params: newParams }, () => {
      this.applyDistFunction();
      this.calculateProbability();
    });
  };

  render() {
    return (
      <div>
        <h2>Calculate Probability</h2>
        <Row>
          <Col xs="2">
            <label htmlFor="rand-var">Random Variable:</label>{" "}
            <input
              className="form-control"
              id="rand-var"
              type="text"
              value={this.state.randomVariable}
              onChange={this.handleRandomVar}
            />
          </Col>
          <Col xs="4">
            <label htmlFor="select-op">Select Value: </label>
            <Select
              id="select-op"
              value={this.state.operation}
              onChange={this.handleOperation}
              options={operationOptions}
            />
          </Col>
          <Col xs="4">
            <label htmlFor="select-dist">Select Distribution: </label>
            <Select
              id="select-dist"
              value={this.state.distribution}
              onChange={this.handleDistribution}
              options={distributionOptions}
            />
          </Col>
          <Col xs="2">
            <label htmlFor="upper-bound-value">Upper value:</label>{" "}
            <input
              className="form-control"
              id="upper-bound-value"
              type="number"
              value={this.state.upper}
              onChange={this.handleUpper}
            />
          </Col>
        </Row>
        <div
          style={{
            display: "flex",
            backgroundColor: "lightgreen",
            margin: "2rem",
            padding: "1rem",
            textAlign: "center",
            justifyContent: "center"
          }}
        >
          <Col xs={2}>
            {Object.keys(this.state.params).map(k => {
              return (
                <div key={k}>
                  <DistributionParam
                    keyName={k}
                    param={this.state.params[k]}
                    onChange={this.handleParamsChange}
                  />
                </div>
              );
            })}
          </Col>
          <Col>
            {`${this.state.randomVariable} ~ ${
              this.state.distribution.value
            }(${getDistrbutionParams(this.state.params)})`}
          </Col>
        </div>
        <Row
          style={{
            display: "flex",
            backgroundColor: "lightblue",
            margin: "2rem",
            padding: "1rem",
            textAlign: "center",
            justifyContent: "center"
          }}
        >
          <Row>
            {`P(${this.state.randomVariable} ${
              this.state.operation.value
                ? this.state.operation.value
                : "Operation?"
            } ${this.state.upper}) = ${this.state.output}`}
          </Row>
        </Row>
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
          <Col>{`Mean = ${this.state.mean}`}</Col>
          <Col>
            {`Var(${this.state.randomVariable}) = ${this.state.variance}`}
          </Col>
          <Col>{`Sd(X) = ${Math.sqrt(this.state.variance)}`}</Col>
        </Row>
      </div>
    );
  }
}

const getDistrbutionParams = params => {
  // console.log({ dist });
  let str = "";
  for (let p in params) {
    str += `${p}=${params[p]},`; //  = ${dist[params][p]}`;
  }
  return str;
};
