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

## peaks_func

## Author: LaySent <laysent@gmail.com>
## Keywords: Artificial Fish Algorithm
## Created: 2012-11-23

function [ret] = peaks_func(position)
  if size(position)(2) != 2 || size(position)(1) != 1
    printf("Can't use Peaks function, as size(position)(2) != 2\n");
  else
    x = position(1, 1);
    y = position(1, 2);
    ret = 3*(1-x)^2*exp(-x^2 - (y+1)^2) \
	  - 10*(x/5 - x^3 - y^5)*exp(-x^2-y^2) \
	  - 1/3*exp(-(x+1)^2 - y^2);
  endif
endfunction
