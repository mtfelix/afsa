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

function [f, position] = swarm (pos, list, tryNumber, step, visual, \
				jamming)
  position = pos;
    f = food(pos);
    tmpList = [];
    fishNum = size(list)(1);
    for i = 1:fishNum
        if isequal(pos,list(i,:))
            continue;
        endif
        if getDistance(list(i,:), pos) <= visual
            temList = [tmpList; list(i,:)];
        endif
    endfor

    if size(tmpList)(1) != 0
        center = mean(tmpList);
        if food(center)./size(tmpList)(1) > jamming * f
            dirVector = center .- pos;
            direction = dirVector./norm(dirVector);
            position = getNewPosition(pos, step, direction);
        endif
    endif

endfunction
