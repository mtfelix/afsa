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

function [f, position, unionFind, stepsOfPrey] = prey(pos, fish, tryNumber, step, \
						      visual, self, \
						      unionFind, \
						      stepsOfPrey,data)
  f = getFood(pos,data);  
  m = size(fish)(1);
  tmpf = f;
  j = -1;
  for i = 1:m
    if i == self
      continue;
    endif
    if getDistance(fish(i,:), pos) <= visual && getFood(fish(i,:),data) > \
	  tmpf
      tmpf = getFood(fish(i,:),data);
      j = i;
    endif
  endfor
    for i=1:tryNumber
      while 1
	tempPosition = getNewPosition(pos, step);
	if j != -1 && dot(tempPosition, fish(j,:)) < 0
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
        if getFood(tempPosition,data) > getFood(pos,data)
	  if stepsOfPrey(self, 1) >= 3
	    unionFind = UF_Break(unionFind, fish, self);
	    stepsOfPrey(self, 1) = 0;
	  else
	    stepsOfPrey(self, 1) += 1;
	  endif
          break;
        endif
    endfor
    position = tempPosition;
    f = getFood(position,data);

endfunction
