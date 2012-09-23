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

function [f, position, unionFind] = swarm (pos, list, tryNumber, step, visual, \
				jamming, unionFind, self)
  position = pos;
    f = getFood(pos);
    tmpList = [];
    tmpIter = [];
    fishNum = size(list)(1);
    for i = 1:fishNum
        if isequal(pos,list(i,:))
            continue;
        endif
        if getDistance(list(i,:), pos) <= visual
            temList = [tmpList; list(i,:)];
	    tmpIter = [tmpIter; i];
        endif
    endfor

    if size(tmpList)(1) != 0
        center = mean(tmpList);
        if getFood(center)./size(tmpList)(1) > jamming * f
	  for i = 1:size(tmpIter)(1)
	    unionFind = UF_union(unionFind, tmpIter(i), self);
	  endfor
            dirVector = center .- pos;
            direction = dirVector./norm(dirVector);
            position = getNewPosition(pos, step, direction);
	    f = getFood(position);
        endif
    endif

endfunction
