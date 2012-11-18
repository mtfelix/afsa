function [boolean] = UF_Connected(p, q)
  if UF_Find(p) == UF_Find(q)
    boolean = 1;
  else
    boolean = 0;
  endif
endfunction
