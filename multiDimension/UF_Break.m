function [] = UF_Break(p)
#  printf("Break %d\n",p);
  global unionFind;
  if unionFind(p) != p
    for i = 1:size(unionFind)(2)
      if i != p && unionFind(i) == p
	unionFind(i) = unionFind(p);
      endif
    endfor
    unionFind(p) = p;
  endif
endfunction
