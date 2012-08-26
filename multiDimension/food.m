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

## food

## Author: reAsOn <reason@For-Napkin>
## Created: 2012-08-17

% original form
%-----------------------
%function [y]=food(x)
%    y = sin(x.*x)./x;
%endfunction
%-----------------------


function [food] = food(position)
    load data.mat;
    food = 0;
    % match the dimension of coordinate and data
    if length(position') != size(data)(2)
        printf("In food function: dimension not match!\n")
    else
        diff = data .- (ones(length(data),1) * position);
        distance_sum = sqrt(sum(diff.^2));
        food = kMeanFunction(distance_sum);
    end
endfunction
