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

function [f, position, unionFind, stepsOfPrey, getFoodCount] = follow (pos, list, tryNumber, step, visual, \
				 jamming, unionFind, stepsOfPrey, \
				 iter, data, getFoodCount, food)
  position = list(pos,:);
  f = food(pos);
%  [f,getFoodCount] = getFood(list(pos,:),data, getFoodCount);
  tmpf = f;
  m = size(list)(1);
  j = -1;
  for i = 1:m
    %if isequal(pos, list(i,:))
    if i == pos
      continue;
    endif
    if getDistance(list(i,:),list(pos,:)) <= visual && \
       food(i) > tmpf
%      getFood(list(i,:),data)>tmpf


%      [tmpf, getFoodCount] = getFood(list(i,:),data, getFoodCount);
       tmpf = food(i);
      j = i;
    endif
%    getFoodCount+=1;
  endfor
  
  friends = 0;
  if j != -1
    for i = 1:m
      if i == j
        continue;
      endif
      if getDistance(list(i,:),list(j,:)) <= visual
        friends = friends + 1;
      endif
    endfor
%    if getFood(list(j,:),data) > jamming * getFood(list(pos,:),data) * friends
    if food(j) > jamming * food(pos) * friends
      [unionFind, getFoodCount] = UF_Union(unionFind, list, pos, j, \
					   iter,data, getFoodCount, food);
      stepsOfPrey(pos, 1) = 0;
      dirVector = list(j,:) - list(pos,:);
      direction = dirVector./ norm(dirVector);
      position = getNewPosition(list(pos,:), step, direction);
      [f,getFoodCount] = getFood(position,data, getFoodCount);
    endif
%    getFoodCount += 2;
  endif

endfunction
