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

## getDistance

## Author: reAsOn <reason@For-Napkin>
## Author: LaySent
## Created: 2012-08-17

function [distance] = getDistance (position1, position2)
%% ========== 说明 ==========
%  以下计算了三种范数, 任意一种均可以用于表示两点间的距离
%  可以根据实际情况需要进行选择
%

%% 计算两坐标的分量差
    diff = position1 - position2;

%% ========== 一范数 ==========
%  即曼哈顿距离, 计算方法为:
%  两坐标的分量差的绝对值的和
%
    distance = sum(abs(diff));

%% ========== 二范数 ==========
%  即欧拉距离, 计算方法为:
%  两坐标的分量差的平方和开根号
%  为了计算方便, 一般可以考虑省略开根号的步骤
%  另, 而范数可用向量点乘来计算, 用Octave实现起来速度更快
%    distance = sqrt(sum(diff*diff'));

%% ========== 无穷范数 ==========
%  即切比雪夫范数, 计算方法为:
%  两坐标的分量差的绝对值中的最大值
%
%    distance = max(abs(diff));
endfunction
