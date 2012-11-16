function [id] = UF_Find(p)
  global unionFind;
  if p <= 0 || p > size(unionFind)(2)
    id = -1;
    if p <= 0
      printf("In UF_Find p is negative");
    endif
    if p > size(unionFind)(2)
      printf("In UF_Find p = %d is greater than unionFind = %d\n", p, 
	     size(unionFind)(2));
    endif
  else
    id = p;
    while id != unionFind(id)
      id = unionFind(id);
    endwhile
  endif  
  if id == 0
    printf("In UN_Find id == 0\n");
  endif
  fflush(stdout);
endfunction
