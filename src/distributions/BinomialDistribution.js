import factorial from "./Factorial";

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

const binomialDistribution = ({ n, p }) => {
  return {
    prob: x => choose(n, x) * Math.pow(p, x) * Math.pow(1 - p, n - x),
    mean: p,
    var: (1 - p) * p,
    discrete: true
  };
};
export default binomialDistribution;
