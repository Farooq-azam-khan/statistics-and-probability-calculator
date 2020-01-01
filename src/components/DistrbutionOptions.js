import geometricDistribution from "../distributions/GeometricDistribution";
import binomialDistribution from "../distributions/BinomialDistribution";
import uniformContinuousDistribution from "../distributions/UniformContinuousDistribution";
import poissionDistribution from "../distributions/PoissionDistribution";

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
  {
    value: "uniform-continuous",
    label: "uniform continuous",
    discrete: true,
    func: uniformContinuousDistribution,
    params: { b: 0, a: 0 }
  },
  //   { value: "uniform-discrete", label: "uniform discrete", discrete: true },

  {
    value: "poission",
    label: "poission",
    discrete: true,
    func: poissionDistribution,
    params: { lambda: 0 }
  }
  //   { value: "gamma", label: "gamma", discrete: false },
  //   { value: "exponential", label: "exponential", discrete: false },
  //   { value: "normal", label: "normal", discrete: false }
];

export default distributionOptions;
