const uniformContinuousDistribution = ({ b, a }) => {
  return {
    prob: _ => 1 / (b - a),
    mean: (a + b) / 2,
    var: ((b - a) * (b - a)) / 12,
    discrete: true
  };
};
export default uniformContinuousDistribution;
