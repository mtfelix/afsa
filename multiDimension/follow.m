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

function [f, position, unionFind] = follow (pos, list, tryNumber, step, visual, \
				 jamming, unionFind, self)
  position = pos;
  f = getFood(pos);
  m = size(list)(2);
  j = -1;
  for i = 1:m
    if isequal(pos, list(i,:))
      continue;
    endif
    if getDistance(list(i,:),pos) <= visual && getFood(list(i,:))>f
      f = getFood(list(i,:));
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
    if getFood(list(j,:)) > jamming * getFood(pos) * friends
      unionFind = UF_Union(unionFind, list, j, self);
      dirVector = list(j,:) - pos;
      direction = dirVector./norm(dirVector);
      position = getNewPosition(pos, step, direction);
      f = getFood(position);
    endif
  endif

endfunction
