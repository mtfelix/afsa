function [result] = condition(iter,x,boardx,visual)
  global iter;
  count = 0;
  if iter<10
%    tmp = x>=(boardx-visual);
%    tmp += (x<=(boardx+visual));
%    for i = 1:size(tmp)(2)
%      if tmp(i)==2
%	count=count+1;
%      endif
%    endfor
%    if count>20
%      result=0;
%    else
%      result=1;p
%    endif
    result = 1;
  else
    result=0;
  endif
endfunction
