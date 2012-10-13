function [ret, num] = UF_Check(unionFind)
  num = [];
  ret = [];
  for i = 1:size(unionFind)(2)
    tmp = UF_Find(unionFind, i);    
    boolean = 1;
    for j = 1:size(ret)(1)
      if UF_Find(unionFind,num(j,1)) == tmp
	ret(j,1) += 1;
	boolean = 0;
	break;
      endif
    endfor
    if boolean
      num = [num; tmp];
      ret = [ret; 1];
    endif
  endfor
endfunction
