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
%  [f,gFoodCount] = getFood(fish(pos,:),data, gFoodCount);  
  global position;
  global tryNumber;
  global step;
  global visual;
  global unionFind;
  global data;
  global gFoodCount;
  global food;
  global stepsOfPrey;
  f = food(pos);
  m = size(position)(1);
  tmpf = f;
  j = -1;
  for i = 1:m
    if i == pos
      continue;
    endif
    if getDistance(position(i,:), position(pos,:)) <= visual && \
       food(i) > tmpf
%      getFood(position(i,:),data, gFoodCount) > tmpf


%      [tmpf,gFoodCount] = getFood(position(i,:),data, gFoodCount);
	  tmpf = food(i);
      j = i;
    endif
    gFoodCount+=1;
  endfor
    for i=1:tryNumber
      while 1
	tempPosition = getNewPosition(position(pos,:), step);
	if j != -1 && dot(tempPosition, position(j,:)) < 0
	  break;
	else
	  if j == -1
	    break;
	  else
	    tempPosition = -1 .* tempPosition;
	    break;
	  endif
	endif
      endwhile
%       if getFood(tempPosition,data) > getFood(position(pos,:),data)
      if getFood(tempPosition, data) > food(pos)
	  if stepsOfPrey(pos, 1) >= 3
	    UF_Break(pos);
	    stepsOfPrey(pos, 1) = 0;
	  else
	    stepsOfPrey(pos, 1) += 1;
	  endif
          break;
        endif
	gFoodCount+=1;
    endfor
    thisFish = tempPosition;
    f = getFood(thisFish);
endfunction
