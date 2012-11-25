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

## plot_cluster

## Author: reAsOn <reason@For-Napkin>
## Author: LaySent <laysent@gmail.com>
## Created: 2012-08-26

function [] = plot_pic (position, food, iter)
    global data;
    global img_size;
    A = double(imread('bird_small.png'));
    if isempty(data)
       img_size = size(A);
       data = reshape(A, img_size(1) * img_size(2), 3);
    endif

    center = plotClass();
    output = data;
    for i = 1 : size(data)(1)
	min = (data(i,:) - center(1, :))*(data(i,:) - center(1, :))';
	min_idx = 1;
	for j = 2:size(center)(1)
	    if (data(i, :) - center(j,:)) * (data(i, :) - center(j, :))' < min
	       min = ((data(i,:) - center(j, :)) * (data(i, :) - \
						    center(j,:))');
	       min_idx = j;
	    endif
	endfor
	output(i, :) = center(min_idx, :);
	printf("data %d DONE\n", i);
    endfor
    
    subplot(1, 2, 1);
    imagesc(A);
    title('Original');

    subplot(1, 2, 2);
    output_reshape = reshape(output, img_size(1), img_size(2), 3);
    imagesc(output_reshape);

    printf("Centers = %d\n", size(center)(1));

    pause();
endfunction
