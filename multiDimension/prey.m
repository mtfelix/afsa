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

function [f, position, unionFind] = prey(pos, fish, tryNumber, step, self, unionFind)

    for i=1:tryNumber
        tempPosition = getNewPosition(pos, step);
        if getFood(tempPosition) > getFood(pos)
	  unionFind = UF_Break(unionFind, fish, self);
            break;
        endif
    endfor
    position = tempPosition;
    f = getFood(position);

endfunction
