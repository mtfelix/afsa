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
## Created: 2012-08-24

function [f, position] = follow (pos, list, tryNumber, step, visual, jamming)
  position = pos;
    f = food(pos);
    m = size(list)(1);
    j = -1;
    for i = 1:m
        if isequal(pos, list(i,:))
            continue;
        endif
        if getDistance(list(i,:),x) <= visual && food(list(i,:))>f
            f = food(list(i,:);
            j = i;
        endif
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
        if food(list(j,:)) > jamming * food(pos) * friends
            dirVector = list(j,:) .- list(i,:);
            direction = dirVector./norm(dirVector);
            position = getNewPosition(pos, step, direction);
        endif
    endif

endfunction
