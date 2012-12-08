%% ==================== 说明 ====================
%  本函数主要用于检测两个元素是否同属一个集合
%
function [boolean] = UF_Connected(p, q)

%% 如果两个元素所在集合编号相同, 则属于同个集合, 否则不是
  if UF_Find(p) == UF_Find(q)
    boolean = 1;
  else
    boolean = 0;
  endif

endfunction
