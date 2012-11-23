## Copyright (C) 2012 LaySent
## 
## This program is free software; you can redistribute it and/or modify
## it under the terms of the GNU General Public License as published by
## the Free Software Foundation; either version 2 of the License, or
## (at your option) any later version.
## 
## This program is distributed in the hope that it will be useful,
## but WITHOUT ANY WARRANTY; without even the implied warranty of
## MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
## GNU General Public License for more details.
## 
## You should have received a copy of the GNU General Public License
## along with Octave; see the file COPYING.  If not, see
## <http://www.gnu.org/licenses/>.

## generateGrid

## Author: LaySent
## Created: 2012-11-22

%% ==================== 说明 ====================
%  本函数主要用于产生一个给定范围内的均匀排列的数据点
%  范围由bound给定, 数据点个数由num给定
%  注意: 实际产生数据点个数 = num ^ 维数
%  如: num = 4 在二维时产生16个数据点, 在三维时产生64个数据点
%  返回的ret为一个列向量, 其中的每一行代表一个数据点坐标
%
function [ret] = generateGrid(bound, num)

%% 由于至少有上下限两个点, 所以分割至少为2
  if num <= 1
    printf("分割至少为2\n");
  endif

%% 初始化返回值
  ret = zeros(num ^ size(bound)(1), size(bound)(1));

%% 计算维数
%  这里bound是一个m*2的矩阵, 其中bound(:,1)是下限, bound(:,2)是上限
%
  m = size(bound)(1);

%% iter是一个列向量, 每个分量对应于一个维度
%  向量用于记录循环次数
  iter = zeros(m, 1);

%% steps是一个列向量, 每个分量对应于一个维度的步长
%  计算方法是上限减去下限除以个数
%  注意, 分成num个点说明其中的间隔只有num - 1个
%
  steps = zeros(m, 1);
  for i = 1:size(iter)(1)
    steps(i,1) = (bound(i,2) - bound(i,1)) / (num - 1);
  endfor

%% ========== 说明 ==========
%  具体的运算过程和n进制下的数数类似:
%  ``个位''到达上限, 则``十位''加一, ``个位''清零
%  如此反复, 直到``最高位''达到上限
%

%% i = m 指从``最低位''开始计算
  i = m;
  ret_iter = 1;
%% iter(1, 1)是``最高为'', 若不足num则循环未结束
  while (iter(1,1) != num)

	tmp = zeros(1, m);
%% 以下计算下一个数据点的位置
%  具体执行内容和其后注释中的代码等价
%  但使用向量化可以在Octave中加快速度
	tmp(1, :) = (bound(:, 1) + steps(:, 1) .* iter(:, 1))';
%% ==================== 上下两种方式等价 ===================== %%
%%	for j = 1:m                                          %%
%%	    tmp(1, j) = bound(j,1) + steps(j,1) * iter(j,1); %%
%%	endfor                                               %%
%% ========================================================= %%

%% 将新的数据点加入到返回值中
	ret(ret_iter, :) = tmp(1, :);
%% 增加iter的值, 并判断``高位''是否达到需要``进位''的条件
	iter(i, 1) += 1;
	ret_iter += 1;
	if iter(i, 1) == num && i != 1
	   k = i;
	   while iter(k, 1) == num && k != 1
		 k -= 1;
		 iter(k, 1) += 1;
	   endwhile
	   for j = k+1:m
	       iter(j, 1) = 0;
	   endfor
	endif

  endwhile  % while (iter(1,1) != num)
endfunction
