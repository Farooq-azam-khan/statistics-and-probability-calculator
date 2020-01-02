import React from "react";
import { Row } from "react-bootstrap";
import operationOptions from "./OperationOptions";
import distributionOptions from "./DistrbutionOptions";
import DisplayExpectations from "./DisplayExpectations";
import DisplayProbability from "./DisplayProbability";
import DisplayDistribution from "./DisplayDistribution";
import DisplayParams from "./DisplayParams";
import DisplayDistrbutionForm from "./DisplayDistributionForm";

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

    const upper = this.state.upper;
    const operationValue = this.state.operation.value;
    const distrbFunc = this.state.distribution.func(this.state.params);

    if (this.state.distribution.discrete) {
      // TODO: apply the central limit theorem here
      // also might need a switch statement
      if (operationValue === "<=") {
        sumIt = sumUpToX(upper, distrbFunc) + distrbFunc.prob(upper);
      } else if (operationValue === "<") {
        sumIt = sumUpToX(upper, distrbFunc);
      } else if (operationValue === ">") {
        sumIt = 1 - (sumUpToX(upper, distrbFunc) + distrbFunc.prob(upper));
      } else if (operationValue === ">=") {
        sumIt = 1 - sumUpToX(upper, distrbFunc);
      } else if (operationValue === "=") {
        sumIt = distrbFunc.prob(upper);
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
        <DisplayDistrbutionForm
          randomVariable={this.state.randomVariable}
          handleRandomVar={this.handleRandomVar}
          operation={this.state.operation}
          handleOperation={this.handleOperation}
          distribution={this.state.distribution}
          handleDistribution={this.handleDistribution}
          upper={+this.state.upper}
          handleUpper={this.handleUpper}
        />
        <DisplayParams
          params={this.state.params}
          onChange={this.handleParamsChange}
        />
        <DisplayDistribution
          randomVariable={this.state.randomVariable}
          params={this.state.params}
          value={this.state.distribution.value}
        />

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
          <DisplayProbability
            randomVariable={this.state.randomVariable}
            value={this.state.operation.value}
            upper={this.state.upper}
            output={this.state.output}
          />
        </Row>
        <DisplayExpectations
          mean={this.state.mean}
          variance={this.state.variance}
          randomVariable={this.state.randomVariable}
        />
      </div>
    );
  }
}

const sumUpToX = (upper, distrbFunc) => {
  let sumIt = 0;
  for (let x = 0; x < upper; x++) {
    const p_of_x = distrbFunc.prob(x);
    sumIt += p_of_x;
  }
  return sumIt;
};
