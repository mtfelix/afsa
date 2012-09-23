function [id] = UF_Find(list, p)
  if p <= 0 || p > size(list)(2)
    id = -1;
    if p <= 0
      printf("In UF_Find p is negative");
    endif
    if p > size(list)(2)
      printf("In UF_Find p = %d is greater than list = %d\n", p, 
	     size(list)(2));
    endif
  else
    id = p;
    while id != list(id)
      id = list(id);
    endwhile
  endif  
  if id == 0
    printf("In UN_Find id == 0\n");
  endif
  fflush(stdout);
endfunction