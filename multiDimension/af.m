e## Copyright (C) 2012 reAsOn
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
## Author: LaySent <laysent@gmail.com>
## Keywords: Artificial Fish Algorithm
## Created: 2012-08-12

function [ ret ] = af ()

% algorithm start

% clean the screen
clc;

% clean log files
system("mkdir -p log");
system("rm -v log/*");

% turn on the debug mode
debug_on_warning (1);
% parameter initialization

% training set is stored in file data.mat with the name of data
%load data.mat;
load ex7data2.mat;
data = X;

tryNumber = 3;
step = 0.5;
visual = 2.5;
jamming = 0.0526;
iter = 0;
ansBoard = -inf;
positionBoard = ones(%size(data)(2)
		     1, size(data)(2)) .* (-inf);
fishNum = 50;

% initial fish position by random 
position = rand(%size(data)(2)
		fishNum, size(data)(2))*20-10;
tmpPosition = zeros(%size(data)(2)
		    fishNum, size(data)(2));
food = zeros(1, fishNum);
tmpFood = zeros(1, fishNum);
% calculate the food of position
% TODO: let getFood function able to accept matrix
for i = 1: fishNum
    food(i) = getFood(position(i,:));
endfor
%checkFood(-10,10,1);

% Initialize the Union Find Part
unionFind = UF_Create(fishNum);

% check the initialization
%plotFigure(position, food);

minClass = fishNum;
stepsOfPrey = zeros(fishNum , 1);
% main loop
while(condition(iter, position, positionBoard, visual) == 1)

  for i = 1:fishNum
    choice = 1;

    fileName = strcat("log", num2str(i));
    fid = fopen(strcat("log/",fileName), "a+");

    while (choice <= 5)
      switch(choice)
	% the order of follow
	  case 2
	    [tmpFood(i), tmpPosition(i, :), unionFind, stepsOfPrey] = \
		follow(position(i,:), position, tryNumber, step, \
		       visual, jamming, unionFind, i, stepsOfPrey);
	% the order of prey
	  case 3
            [tmpFood(i), tmpPosition(i,:), unionFind, stepsOfPrey] = \
		prey(position(i,:), position, tryNumber, step, visual, i, \
		     unionFind, stepsOfPrey);	    
	  case 1
	% the order of swarm
	  case 6
            [tmpFood(i), tmpPosition(i,:), unionFind, stepsOfPrey] = \
                swarm(position(i,:), position, tryNumber, step,
                      visual, jamming, unionFind, i, stepsOfPrey);
	% the order of random move
	  case 4
            tmpPosition(i,:) = \
                getNewPosition(position(i,:), step);
            tmpFood(i) = getFood(tmpPosition(i,:));
	    if stepsOfPrey(i, 1) >= 1
	      unionFind = UF_Break(unionFind, position, i);
	      stepsOfPrey(i, 1) = 0;
	    else
	      stepsOfPrey(i, 1) += 1;
	    endif
	% here means: use random move and didn't get a good result
	  case 5
	    printf("iter(%d):%d\n",i,choice);
	% just in case
	  otherwise
	    printf("The Switch Operation Occurs Some Trouble\n");
      endswitch
      if tmpFood(i) <= food(i)
	    choice += 1;
      else
	    printf("iter(%d):%d\n",i,choice);
        fprintf(fid, "choice %d", choice);
        fprintf(fid, " --> position %f %f \n", tmpPosition(i,:));
        fclose(fid);
        break;
      endif
    endwhile
    endfor
    if ansBoard < max(tmpFood)
        [ansBoard, ansBoardIndex] = max(tmpFood);
        positionBoard = tmpPosition(ansBoardIndex);
    endif
% the minClass would work!
%    result = UF_Check(unionFind);
%    if minClass > size(result)(1)
%      minClass = size(result)(1)
%      result = result'
%      unionFind = unionFind
%    endif
    position = tmpPosition;
    food = tmpFood;
    
    iter = iter + 1;
    printf("Iteration %d DONE\n",iter);
    fflush(stdout);
%    plotFigure(position, food);
endwhile

fileName = "logFinal";
fid = fopen(strcat("log/",fileName), "w");
fprintf(fid, "Full position matrix: \n");
fprintf(fid, "%f %f \n", position');

% output final answer
printf("Board = %f\n",ansBoard);
printf("Boardx = %f\n", positionBoard);
printf("Iter = %f\n",iter);

% draw some figure
plotFigure(position, food);

% check UF result
[result, num] = UF_Check(unionFind);
printf("Class = %d\n", size(result)(1));
result'
unionFind

plotClass(unionFind, position, food);
endfunction
