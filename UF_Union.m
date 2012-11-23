%% ==================== 说明 ====================
%  本函数用于将两个下标所表示的元素所在的集合合并起来
%
function [] = UF_Union(p, q)
%% ========== 声明全局变量 ==========
%
  global food;
  global unionFind;
  global maxIter;
  global iter;
%% ========== 说明 ==========
%  在前期, 将元素先从集合中分离出去再合并起来,
%  有助于避免两个相近的分类因为follow的连续传递关系而合并成一个
%
  if iter <= maxIter - 2
    UF_Break(p);
    UF_Break(q);
  endif
 
  i = UF_Find(p);
  j = UF_Find(q);
  if i != j
%% 此处判断哪部分为双亲节点的依据在于食物浓度
%  食物浓度大者为双亲 
   if food(i) < food(j)
      unionFind(i) = j;
    else
      unionFind(j) = i;
    endif

  endif

endfunction
