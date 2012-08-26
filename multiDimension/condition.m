function [result] = condition(iter,x,boardx,visual)
  count = 0;
  if iter<10
    tmp = x>=(boardx-visual);
    tmp += (x<=(boardx+visual));
    for i = 1:size(tmp)(2)
      if tmp(i)==2
	count=count+1;
      endif
    endfor
    if count>20
      result=0;
    else
      result=1;
    endif
  else
    result=0;
  endif
endfunction
