%% ==================== 说明 ====================
%  本函数用于将两个下标所表示的元素所在的集合合并起来
%
function [] = uf_union(p, q, idx)
%% ========== 声明全局变量 ==========
%
  global food;
  global unionFind;
  global maxIter;
  global iter;
%% ========== 说明 ==========
%  在前期, 将元素先从集合中分离出去再合并起来,
%  有助于避免两个相近的分类因为follow的连续传递关系而合并成一个
%  WARNING: 原来的算法在这里有漏洞:
%  原来的算法将两个点都从原来的集合中分离出去后在合并, 相当于两点合并
%  因而本次的操作其实和上一步的操作完全无关
%  既然如此, 现在的做法是在步数没有达到要求的情况下直接return而不做任何操作,
%  更为方便直接
%  这里为真正的union留了两步
%
%  if iter < maxIter - 2;
%     return;
%    UF_Break(p);
%    UF_Break(q);
%  endif
 
  i = uf_find(p, idx);
  j = uf_find(q, idx);
  if i != j
%% 此处判断哪部分为双亲节点的依据在于食物浓度
%  食物浓度大者为双亲 
   if food(i) < food(j)
      unionFind(idx, i) = j;
    else
      unionFind(idx, j) = i;
    endif

  endif

endfunction
