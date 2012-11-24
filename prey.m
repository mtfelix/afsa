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

## prey

## Author: reAsOn <reason@For-Napkin>
## Created: 2012-08-17

function [f, thisFish] = prey(pos)
%% ========== 声明全局变量 ==========
%
  global position;
  global tryNumber;
  global step;
  global visual;
  global unionFind;
  global data;
  global gFoodCount;
  global food;
  global stepsOfPrey;
  global fishNum;
  global maxPreyNum
  global feature_uf;
  global getFood;

%% 获得需要计算的鱼的坐标以及所处位置的食物浓度
  f = food(pos);
  thisFish = position(pos,:);

%% 进行最多tryNumber次的试验
%  其中前tryNumber-1次的试验会判断取值是否更合理
%  若没有更合适, 则继续尝试
  for i=1:tryNumber-1

%% 获取新的位置
    tempPosition = getNewPosition(position(pos,:));

%% 判断新的位置是否更加合理
    if getFood(tempPosition(1,:), data) > food(pos)

%% 若更加合理,则朝该位置移动,并做如下工作
%  判断连续执行prey的次数是否达到规定的上限
%  若达到上限, 则执行UF_Break语句
%  否则, 次数加一
%  同时, 将结果存储到返回值中并退出循环
%
      if feature_uf
	if stepsOfPrey(pos, 1) >= maxPreyNum
	  UF_Break(pos);
	  stepsOfPrey(pos, 1) = 0;
	else
	  stepsOfPrey(pos, 1) += 1;
	endif
      endif

%% 保存这次的结果 
      thisFish = tempPosition;
      f = getFood(thisFish);

      return;

    endif  % if getFood(tempPosition, data) > food(pos)

  endfor   % for i=1:tryNumber

%% 若前tryNumber-1次尝试没有获得更好的值
%  第tryNumber次无需再做判断(此处相当于random move)
%
  thisFish = getNewPosition(position(pos,:));
  f = getFood(thisFish);

endfunction
