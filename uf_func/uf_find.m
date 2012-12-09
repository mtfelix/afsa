%% ==================== 说明 ====================
%  本函数主要用于查找制定元素所在集合的编号
%
function [id] = uf_find(p, idx)
%% ========== 声明全局变量 ==========
% 
  global unionFind;

%% ========== 一些鲁棒性的检测 ==========
%
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
%% ========== 查找 ==========
%  递归查找树的顶端节点
%  更详细的说明可以参考并查集的算法说明
    id = p;
    while id != unionFind(idx, id)
      id = unionFind(idx, id);
    endwhile
  endif

endfunction
