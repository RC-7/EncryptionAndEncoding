function [x3, x4] = transpose91()
  ninetyOne=readfile('91.txt');
  firstTranspose=encolumn(ninetyOne,7);
  secondTranspose=encolumn(firstTranspose,13);
  x3 = firstTranspose;
  x4 = secondTranspose;
end

