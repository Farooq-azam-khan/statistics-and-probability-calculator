import React from "react";
import Select from "react-select";
import { Row, Col } from "react-bootstrap";

const operationOptions = [
  { value: "=", label: "=" },
  { value: "<=", label: "<=" },
  { value: ">=", label: ">=" },
  { value: "<", label: "<" },
  { value: ">", label: ">" }
];

const distributionOptions = [
  { value: "geometric", label: "geometric" },
  { value: "uniform-discrete", label: "uniform discrete" },
  { value: "binomial", label: "binomial" },
  { value: "poission", label: "poission" },
  { value: "gamma", label: "gamma" },
  { value: "exponential", label: "exponential" },
  { value: "normal", label: "normal" }
];
export default class Distributions extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      randomVariable: "X",
      lower: 0,
      upper: 1,
      operation: "<",
      distribution: "",
      mean: 0,
      variance: 0,
      output: Math.random()
    };
  }

  calculateProbability = e => {
    this.setState({ output: Math.random() });
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
      console.log(`Option selected:`, this.state.operation);
      this.calculateProbability();
    });
  };

  handleRandomVar = e => {
    this.setState({ randomVariable: e.target.value });
  };

  handleDistribution = distribution => {
    this.setState({ distribution }, () => {
      this.calculateProbability();
    });
  };
  render() {
    return (
      <div>
        <h2>Calculate Probability</h2>
        <Row>
          <Col xs="2">
            <label for="rand-var">Random Variable:</label>{" "}
            <input
              className="form-control"
              id="rand-var"
              type="text"
              value={this.state.randomVariable}
              onChange={this.handleRandomVar}
            />
          </Col>
          <Col xs="4">
            <label for="select-op">Select Value: </label>
            <Select
              id="select-op"
              // defaultMenuIsOpen={true}
              // defaultInputValue={operationOptions[0].label}
              value={this.state.operation}
              onChange={this.handleOperation}
              options={operationOptions}
            />
          </Col>
          <Col xs="4">
            <label for="select-dist">Select Distribution: </label>
            <Select
              id="select-dist"
              // defaultMenuIsOpen={true}
              // defaultInputValue={operationOptions[0].label}
              value={this.state.distribution}
              onChange={this.handleDistribution}
              options={distributionOptions}
            />
          </Col>
          <Col xs="2">
            <label for="upper-bound-value">Upper value:</label>{" "}
            <input
              className="form-control"
              id="upper-bound-value"
              type="number"
              value={this.state.upper}
              onChange={this.handleUpper}
            />
          </Col>
        </Row>
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
        <div
          style={{
            backgroundColor: "red",
            margin: "2rem",
            padding: "2rem",
            textAlign: "center",
            color: "white",
            justifyContent: "center"
          }}
        >
          <h3>Distribution Test</h3>
          <h4>Geometric</h4>
          <div>{geometricDistribution(0.01).prob(10)}</div>
          <div>{geometricDistribution(0.01).mean}</div>
          <div>{geometricDistribution(0.01).var}</div>
          <h4>Binomial</h4>
          <div>{binomialDistribution(8, 0.2).prob(2)}</div>
          <div>{binomialDistribution(8, 0.2).mean}</div>
          <div>{binomialDistribution(8, 0.2).var}</div>
        </div>
      </div>
    );
  }
}

function factorial(x) {
  // validating the input
  x = parseInt(x, 10);
  if (isNaN(x)) return 1;

  // if x below 0, return 1
  if (x <= 0) return 1;
  // if x above 170, return infinity
  if (x > 170) return Infinity;
  // calculating the factorial
  var y = 1;
  for (var i = x; i > 0; i--) {
    y *= i;
  }
  return y;
}

function choose(n, k) {
  // validating the input
  n = parseInt(n, 10);
  if (isNaN(n)) n = 0;
  if (n < 0) n = 0;

  k = parseInt(k, 10);
  if (isNaN(k)) k = 0;
  if (k < 0) k = 0;
  if (k > n) k = n;

  return factorial(n) / (factorial(k) * factorial(n - k));
}

const geometricDistribution = p => {
  return {
    prob: x => Math.pow(1 - p, x - 1) * p,
    mean: 1 / p,
    var: (1 - p) / (p * p)
  };
};

const binomialDistribution = (n, p) => {
  return {
    prob: x => choose(n, x) * Math.pow(p, x) * Math.pow(1 - p, n - x),
    mean: p,
    var: (1 - p) * p
  };
};
