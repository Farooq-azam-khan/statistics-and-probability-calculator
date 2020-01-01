import React from "react";
import Select from "react-select";

const operationOptions = [
  { value: "=", label: "=" },
  { value: "<=", label: "<=" },
  { value: ">=", label: ">=" },
  { value: "<", label: "<" },
  { value: ">", label: ">" }
];

export default class Distributions extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      randomVariable: "X",
      lower: 0,
      upper: 1,
      operation: "<",
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
  render() {
    return (
      <div>
        <h2>Calculate Probability</h2>
        <div>
          <label for="rand-var">Random Variable:</label>{" "}
          <input
            id="rand-var"
            type="text"
            value={this.state.randomVariable}
            onChange={this.handleRandomVar}
          />
        </div>
        <div styles={{ margin: "1rem" }}>
          <label for="select-op">Select Value: </label>
          <Select
            id="select-op"
            value={this.state.operation}
            onChange={this.handleOperation}
            options={operationOptions}
          />
          <label for="upper-bound-value">Upper value:</label>{" "}
          <input
            id="upper-bound-value"
            type="number"
            value={this.state.upper}
            onChange={this.handleUpper}
          />
          <div
            style={{
              display: "flex",
              backgroundColor: "lightblue",
              margin: "2rem",
              padding: "1rem",
              textAlign: "center",
              justifyContent: "center"
            }}
          >
            <div>
              P(
              {this.state.randomVariable +
                this.state.operation +
                this.state.upper}
              ) = {this.state.output}
            </div>
          </div>
        </div>
      </div>
    );
  }
}
