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

## cluster_food

## Author: reAsOn <reason@For-Napkin>
## Author: LaySent <laysent@gmail.com>
## Created: 2012-08-17

function [food] = food_pic(position)

  global gFoodCount;
  global data;
  global img_size;
  if isempty(data)
    A = double(imread('bird_small.png'));     
    img_size = size(A);
    data = reshape(A, img_size(1) * img_size(2), 3);
  endif
  if isempty(gFoodCount)
     gFoodCount = 0;
  endif
  gFoodCount += 1;
  food = 0;
% match the dimension of coordinate and data
    if size(position)(2) != size(data)(2)
        printf("In food function: dimension not match!\nwhere \
	    size(position) = %d\n",size(position)(2));
    else
        diff = data .- (ones(length(data),1) * position);
	food = sum(gauss(diff));
    end
endfunction

function [ ret ] = gauss(distance)

%% ========== 高斯分布 ==========
%  函数在零点处最大, 越远离原点值越小
%  同时, 独立变量的高斯分布具有良好的性质:
%  计算多维的高斯分布可以改成计算一维的高斯分布函数, 再相乘
%  这里, 根据指数的性质, 相乘等价于指数相加
%
    ret = exp(-0.5 * sum(distance.^2, 2));	 
endfunction

function [ ret ] = sigmoid(distance)
%% ========== sigmoid函数 ==========
%  原先的sigmoid函数在正半轴取值接近于1, 在负半轴取值接近与0
%  这里改用绝对值后保证在靠近原点处值最大(为0.5), 越远离原点值越小
%  该函数暂时不支持多维问题
%
    ret = 1 ./ (1 + exp(1*abs(distance)));
endfunction
