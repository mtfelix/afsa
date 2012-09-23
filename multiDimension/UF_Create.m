function [list] = UF_Create(N)
  list = zeros(1, N);
  for i = 1:N
    list(i) = i;
  endfor
endfunction