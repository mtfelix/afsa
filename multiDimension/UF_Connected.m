function [boolean] = UF_Connected(list, p, q)
  if UF_Find(list, p) == UF_Find(list, q)
    boolean = 1;
  else
    boolean = 0;
  endif
endfunction