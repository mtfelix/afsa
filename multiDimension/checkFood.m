function [] = checkFood(lower, upper, step);  
  x = lower:step:upper;
  y = lower:step:upper;
  num = (upper - lower) * (1 / step);
  z = zeros(num, num);
  for i = 1: num
    for j = 1: num
      z(i, j) = getFood([i * step+lower j * step+lower]);
    endfor
  endfor
%  plot3(x, y, z);
  contour(z);
endfunction