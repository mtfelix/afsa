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

## getFood

## Author: reAsOn <reason@For-Napkin>
## Author: LaySent <laysent@gmail.com>
## Created: 2012-08-17

% original form (only for single variable)
%-----------------------
%function [y]=getFood(x)
%  y = sin(x)./(x);
%endfunction
%-----------------------

% classification form
%-----------------------
function [food, count] = getFood(position,data, count)
%    load data.mat;
%  load ex7data2.mat;
%  data = X;
	 if nargin == 3
	    count+=1;
	 endif
    food = 0;
% match the dimension of coordinate and data
    if size(position)(2) != size(data)(2)
        printf("In food function: dimension not match!\nwhere \
	    size(position) = %d\n",size(position)(2));
    else
        diff = data .- (ones(length(data),1) * position);
%        distance_sum = sqrt(sum(diff.^2));
%        food = kMeanFunction(distance_sum);
	food = sum(kMeanFunction(diff));
    end
endfunction
%-----------------------
