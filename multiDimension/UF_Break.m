function [list] = UF_Break(list, fish, p)
%  printf("Break %d\n",p);
  if list(p) == p
%    max = -Inf;
%    maxIter = -1;
%    for i = 1:size(list)(2)
%      if i != p && list(i) == p && max < getFood(fish(i,:))
%	max = getFood(fish(i,:));
%	maxIter = i;
%      endif
%    endfor
%    for i = 1:size(list)(2)
%      if i != p && list(i) == p
%	list(i) = maxIter;
%      endif
%    endfor
  else
    list(p) = p;
  endif
endfunction
