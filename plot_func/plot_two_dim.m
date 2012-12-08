## Copyright (C) 2012 LaySent
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

## plot_two_dim

## Author: reAsOn <reason@For-Napkin>
## Author: LaySent <laysent@gmail.com>
## Created: 2012-11-23

function [] = plot_two_dim (position, food, iter)
  persistent x;
  persistent y;
  persistent z;
  persistent t1;
  persistent t2;
  global defineRange;
  global getFood;

  if isempty(x)
     divisionNum = 60;
     t1 = (defineRange(1,2) - defineRange(1,1))/divisionNum;
     t2 = (defineRange(1,2) - defineRange(1,1))/divisionNum;
     [x, y] = meshgrid(defineRange(1,1):t1:defineRange(1,2));
     z = zeros(divisionNum+1, divisionNum+1);
     for i = 1:divisionNum + 1
	 for j = 1:divisionNum + 1
	     z(i,j) = getFood([x(i,j), y(i,j)]);
	 endfor
     endfor
  endif
  contour(defineRange(1,1):t1:defineRange(1,2), 
	  defineRange(2,1):t2:defineRange(2,2),
	 z);
  hold on;
  plot(position(:, 1)', position(:, 2)', "*");
  hold off;
  pause();

endfunction
