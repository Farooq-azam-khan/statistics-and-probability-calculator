import geometricDistribution from "./GeometricDistribution";
import binomialDistribution from "./BinomialDistribution";

const distributionOptions = [
  {
    value: "binomial",
    label: "binomial",
    func: binomialDistribution,
    discrete: true,
    params: {
      n: 0,
      p: 0
    }
  },
  {
    value: "geometric",
    label: "geometric",
    func: geometricDistribution,
    discrete: true,
    params: {
      p: 0
    }
  },
  { value: "uniform-discrete", label: "uniform discrete", discrete: true },

  { value: "poission", label: "poission", discrete: true },
  { value: "gamma", label: "gamma", discrete: false },
  { value: "exponential", label: "exponential", discrete: false },
  { value: "normal", label: "normal", discrete: false }
];

export default distributionOptions;
