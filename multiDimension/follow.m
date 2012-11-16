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

## follow

## Author: reAsOn <reason@For-Napkin>
## Author: LaySent <laysent@gmail.com>
## Created: 2012-08-24

function [f, thisFish] = follow (pos)	 
  global iter;
  global gFoodCount;
  global position;
  global step;
  global visual;
  global tryNumber;
  global jamming;
  global data;
  global food;
  global stepsOfPrey;
  thisFish = position(pos,:);
  f = food(pos);
%  [f,gFoodCount] = getFood(position(pos,:),data, gFoodCount);
  tmpf = f;
  m = size(position)(1);
  j = -1;
  for i = 1:m
    %if isequal(pos, position(i,:))
    if i == pos
      continue;
    endif
    if getDistance(position(i,:),position(pos,:)) <= visual && \
       food(i) > tmpf
%      getFood(position(i,:),data)>tmpf


%      [tmpf, gFoodCount] = getFood(position(i,:),data, gFoodCount);
       tmpf = food(i);
      j = i;
    endif
%    gFoodCount+=1;
  endfor
  
  friends = 0;
  if j != -1
    for i = 1:m
      if i == j
        continue;
      endif
      if getDistance(position(i,:),position(j,:)) <= visual
        friends = friends + 1;
      endif
    endfor
%    if getFood(position(j,:),data) > jamming * getFood(position(pos,:),data) * friends
    if food(j) > jamming * food(pos) * friends
      UF_Union(pos, j);
      stepsOfPrey(pos, 1) = 0;
      dirVector = position(j,:) - position(pos,:);
      direction = dirVector./ norm(dirVector);
      thisFish = getNewPosition(position(pos,:),direction);
      f = getFood(thisFish);
    endif
%    gFoodCount += 2;
  endif

endfunction
