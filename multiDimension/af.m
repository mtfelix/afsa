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

## af

## Author: reAsOn <reason@For-Napkin>
## Created: 2012-08-12

function [ ret ] = af ()

% algorithm start
% parameter initialization

% training set is stored in file data.mat with the name of data
load data.mat;

tryNumber = 3;
step = 0.25;
visual = 2.5;
jamming = 0.526;
iter = 0;
ansBoard = -inf;
positionBoard = ones(size(data)(2), 1) .* (-inf);
fishNum = 100;

% initial fish position by random 
position = rand(size(data)(2), fishNum);
tmpPosition = zeros(size(data)(2), fishNum);
food = zeros(1, fishNum);
tmpFood = zeros(1, fishNum);
% calculate the food of position
% TODO: let getFood function able to accept matrix
for i = 1: fishNum
    food(i) = getFood(position(i,:));
endfor

% main loop
while(condition(iter, position, positionBoard, visual) == 1)
    for i = 1:fishNum
        [tmpFood(i), tmpPosition(i)] = \
        follow(position(i,:), position, tryNumber, step, visual, jamming)
        if tmpFood(i) <= food(i)
            [tmpFood(i), tmpPosition(i)] = \
            prey(position(i,:), tryNumber, step);
            if tmpFood(i) <= food(i)
                [tmpFood(i), tmpPosition(i)] = \
                swarm(position(i,:), position, tryNumber, step,
                visual, jamming);
                if tmpFood(i) <= food(i)
                    tmpPosition = \
                    getNewPosition(position(i,:), step);
                    tmpFood = getFood(tmpPosition);
                endif
            endif
        endif
    endfor
    if ansBoard < max(tmpFood)
        [ansBoard, ansBoardIndex] = max(tmpFood);
        positionBoard = tmpPosition(ansBoardIndex);
    endif
    position = tmpPosition;
    food = tmpFood;
    iter = iter + 1;

endwhile

% output final answer
printf("Board = %f\n",ansBoard);
printf("Boardx = %f\n", ansBoardIndex);
printf("Iter = %f\n",iter);

% TODO: draw some figure


endfunction
