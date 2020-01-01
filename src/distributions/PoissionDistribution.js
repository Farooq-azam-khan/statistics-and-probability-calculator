import factorial from "./Factorial";

const poissionDistribution = ({ lambda }) => {
  return {
    prob: x => (Math.pow(lambda, x) * Math.exp(-lambda)) / factorial(x),
    mean: lambda,
    var: lambda
  };
};
export default poissionDistribution;
