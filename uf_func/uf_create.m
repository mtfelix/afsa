%% ==================== 说明 ====================
%  本函数主要用于初始化一组用于并查集计算的数组
%
function [unionFind] = uf_create(N)
%% 初始化时, 并查集要求元素值等于其下标值
  unionFind = 1 : N;
endfunction
