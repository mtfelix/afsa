## Copyright (C) 2012 reAsOn
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

## getNewPosition

## Author: reAsOn <reason@For-Napkin>
## Created: 2012-08-17

function [newPosition] = getNewPosition (position, direction)
%% ========== 声明全局变量 ==========
%
    global step;
    global defineRange;

%% 为返回值分配初始空间
    newPosition = zeros(1, size(position)(2));

%% 若参数仅为1个, 则缺少方向信息, 默认随机产生一个方向向量
    if nargin == 1

%% 以下产生一个随机向量
%  其中, 向量的每个分量值属于[-0.5, 0.5]的范围区间
%
        dim = size(position)(2);
        randVector = rand(1, dim).-0.5;
%% 单位化方向向量
        direction = randVector ./ norm(randVector);
    endif

%% ========== 计算新的位置 ==========
%  以下提供了两种计算方式
%  1. 移动步长为给定的step值
    newPosition = position + (step .* direction);
%  2. 移动步长为一个随机数, 其范围为[0, step]
%    newPosition = position + (step .* direction .* 
%			      rand(size(direction)(1), size(direction)(2)));

%% 以下判断是否超过了定义域范围
%  超过定义域范围的*分量*做一个镜面反射, 使任意分量均在给定的定义域范围内
%
    for i = 1:size(newPosition(1,:))(2)
%% 超过下限
	if newPosition(1, i) < defineRange(i, 1)
	   newPosition(1, i) -= (newPosition(1, i) - defineRange(i, 1)) * 2;
	endif
%% 超过上限
	if newPosition(1, i) > defineRange(i, 2)
	   newPosition(1, i) -= (newPosition(1, i) - defineRange(i, 2)) * 2;
	endif
    endfor

%% 以下输出debug信息, 一般无须使用
%    printf("%f --> %f\n",position,newPosition);

endfunction
