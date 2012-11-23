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

## swarm

## Author: reAsOn <reason@For-Napkin>
## Created: 2012-08-24

function [f, thisFish] = swarm (pos)
%% ========== 声明全局变量 ==========
%
  global position;
  global visual;
  global jamming;
  global food;
  global stepsOfPrey;
  global fishNum;

%% 获得需要计算的鱼的坐标以及所处位置的食物浓度
  thisFish = position(pos,:);
  f = food(pos);

%% 以下两个列表用于存放自身领域内所有的``邻居''
%  其中tmpList存放邻居的坐标
%  tmpIndex存放其下表
  tmpList = [];
  tmpIndex = [];

  for i = 1:fishNum

%% 若是自身, 则跳过判断
      if pos == i
        continue;
      endif

%% 若在自身的领域内, 则加入到列表中
      if getDistance(position(i,:), position(pos, :)) <= visual
        tmpList = [tmpList; position(i,:)];
	tmpIndex = [tmpIndex; i];
      endif
  endfor

%% 判断领域内是否有``邻居''
  if size(tmpList)(1) != 0
%% 计算所有``邻居''的中心点位置   
     if size(tmpList)(1) == 1
	center = tmpList;
     else
       center = mean(tmpList);
     endif
%% 判断该中心位置是否过于拥挤
    if getFood(center(1,:))./size(tmpList)(1) > jamming * f
%% ========== 符合要求, 执行swarm ==========
%  1. 合并集合(这里因为自身不是向任何一条鱼靠拢,所以不做合并)
%      for i = 1:size(tmpIndex)(1)
%	UF_Union(pos, i);
%      endfor

%  2. 连续prey的次数清零
      stepsOfPrey(pos, 1) = 0;

%  3. 计算方向向量
      dirVector = center .- pos;
      direction = dirVector./norm(dirVector);

%  4. 计算新的位置和新的食物浓度
      thisFish = getNewPosition(position(pos, :), direction);
      f = getFood(thisFish(1,:));
    endif  % if getFood(center(1, :))./size(tmpList)(1) > jamming * f
  endif    % if size(tmpList) != 0
  
endfunction
