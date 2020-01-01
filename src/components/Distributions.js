import React from "react";

export default class Distributions extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
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
    this.setState({ lower: e.target.value });
    this.calculateProbability();
  };

  handleUpper = e => {
    this.setState({ upper: e.target.value });
    this.calculateProbability();
  };
  handleOperation = e => {
    this.setState({ operation: e.target.value });
    this.calculateProbability();
  };

  render() {
    return (
      <div>
        <h2>Calculate Probability</h2>
        P (
        <input
          type="number"
          value={this.state.lower}
          onChange={this.handleLower}
        />{" "}
        <input
          type="text"
          value={this.state.operation}
          onChange={this.handleOperation}
        />{" "}
        <input
          type="number"
          value={this.state.upper}
          onChange={this.handleUpper}
        />
        ) = <span>{this.state.output}</span>
      </div>
    );
  }
}
