const geometricDistribution = ({ p }) => {
  return {
    prob: x => Math.pow(1 - p, x - 1) * p,
    mean: 1 / p,
    var: (1 - p) / (p * p),
    discrete: true
  };
};

export default geometricDistribution;
