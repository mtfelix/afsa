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

## getNewPosition

## Author: reAsOn <reason@For-Napkin>
## Created: 2012-08-17

% previous version
%function [new_x] = getNewX(x,step,position)
%  if position > 0
%    new_x = x + step;
%  else
%    new_x = x - step;
%  endif
%  if new_x>10
%    new_x=10;
%  endif
%  if new_x<-10
%    new_x=-10;
%  endif
%endfunction

function [newPosition] = getNewPosition (position, direction)
    global step;
    if nargin == 1
        dim = size(position)(2);
        randVector = rand(1, dim).-0.5;
        direction = randVector ./ norm(randVector);
    endif
    newPosition = position.+(step.*direction);
%    printf("%f --> %f\n",position,newPosition);
%    if newPosition > 10
%      newPosition = 10;
%    endif
%    if newPosition < -10
%      newPosition = -10;
%    endif
endfunction