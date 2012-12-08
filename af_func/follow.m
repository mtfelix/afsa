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

## -*- texinfo -*-
## @deftypefn {Function File} {[@var{f}, @var{p}] = } follow (@var{i})
## where @var{i} is the index of the fish to use follow-movement
##
## some variables like @var{position} etc should be given as global variables
##
## the function returns two variables: 
## @var{p} is the new position and @var{f} is the new food value
##
## if no better solution can be found using follow-movement,
## @var{p} and @var{f} should return the same value as befor
## @end deftypefn

## Author: reAsOn <reason@For-Napkin>
## Author: LaySent <laysent@gmail.com>
## Created: 2012-08-24

function [f, thisFish] = follow (pos)	 
%% ========== 声明全局变量 ==========
%
  global position;
  global visual;
  global jamming;
  global food;
  global stepsOfPrey;
  global fishNum;
  global feature_uf;
  global getFood;

%% 获得需要计算的鱼的坐标以及所处位置的食物浓度
  thisFish = position(pos,:);
  f = food(pos);

%% ========== 一些有用的变量 ==========
%  tmpf用于记录领域中能找到的最大值
%  初始化时存放自身的食物浓度, 这样可以保证若能找到最大值, 其一定比自身大
%  j用于存放找到的最大值的下标
%  j = -1表示没找到
%
  tmpf = f;
  j = -1;

  for i = 1:fishNum

%% 若是自身, 则跳过判断
    if i == pos
      continue;
    endif

%% 若在视阈内, 且食物浓度比已知的高, 则记录改点坐标和食物浓度
    if getDistance(position(i,:),position(pos,:)) <= visual && food(i) > tmpf
       tmpf = food(i);
       j = i;
    endif

  endfor   % for i = 1:fishNum
  
%% ========== 以下判断拥挤程度 ==========
%  frindes记录最大值所在位置视阈内的鱼群数量
%
  friends = 0;
 
%% 若j == -1, 则没找到符合要求的鱼, 跳过判断步骤
  if j != -1

    for i = 1:fishNum
%% 跳过自身
%  注意: 此时的``自身''的含义已经发生了改变, 判断是否和j相同而不是pos
      if i == j
        continue;
      endif

      if getDistance(position(i,:),position(j,:)) <= visual
        friends = friends + 1;
      endif

    endfor  % for i = 1:fishNum

%% 判断是否``不太拥挤''
    if food(j) > jamming * food(pos) * friends
%% ========== 符合要求, 执行follow ==========
%  1. 合并集合  
      if feature_uf
	UF_Union(j, pos);
      endif

%  2. 连续prey的次数清零
      stepsOfPrey(pos, 1) = 0;

%  3. 计算方向向量
      dirVector = position(j,:) - position(pos,:);
      direction = dirVector./ norm(dirVector);

%  4. 计算新的位置和新的食物浓度
      thisFish = getNewPosition(position(pos,:),direction);
      f = getFood(thisFish);
    endif  % if food(j) > jamming * food(pos) * friends

  endif    % if j != -1

endfunction
