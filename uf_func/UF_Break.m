%% ==================== 说明 ====================
%  本函数用于将下标为p的元素从原有集合中分离出来
%  分离出来的元素新组成一个集合
%
function [] = UF_Break(p)
%% ========== 声明全局变量 ==========
%
  global unionFind;
  global iter;
  global maxIter;

%% ========== 说明 ==========
%  见UF_Union的说明
%
  if iter < maxIter - 2
     return;
  endif

%% ========== 说明(存疑) ==========
%  此处如果unionFind(p) == p, 说明p是树的顶端值
%  由于在union中定义顶端的值一定是食物浓度最高的值
%  故当已经群聚时, 一个集合内的最优解必然只能执行prey语句
%  此时, 无需将这个元素从集合中分离出去
%% 疑问: 
%  此处的设定似乎不使用于初始情况,
%  因为刚开始的鱼可能只是小范围的相互follow
%  
  if unionFind(p) != p
%% ========== 说明 ==========
%  当需要分离出去时, 执行如下操作:
%  1. 找到该节点所有的子节点, 并将这些子节点的父节点改为其祖父节点
    for i = 1:size(unionFind)(2)
      if i != p && unionFind(i) == p
	unionFind(i) = unionFind(p);
      endif
    endfor

%  2. 将自身设置为一个集合
    unionFind(p) = p;

  endif

endfunction
