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

export default factorial;
