function [ret] = generateGrid(bound, num)
  if num <= 1
    printf("分割至少为2\n");
  endif
  ret = [];
  m = size(bound)(1);
  iter = zeros(m, 1);
  steps = zeros(m, 1);
  for i = 1:size(iter)(1)
    steps(i,1) = (bound(i,2) - bound(i,1)) / (num - 1);
  endfor
  i = m;
  while (iter(1,1) != num)
	tmp = zeros(1, m);	
	for j = 1:m
	    tmp(1, j) = bound(j,1) + steps(j,1) * iter(j,1);
	endfor
	ret = [ret; tmp(1,:)];
	iter(i, 1) += 1;
	if iter(i, 1) == num && i != 1
	   k = i;
	   while iter(k, 1) == num && k != 1
		 k -= 1;
		 iter(k, 1) += 1;
	   endwhile
	   for j = k+1:m
	       iter(j, 1) = 0;
	   endfor
	endif
  endwhile
endfunction
