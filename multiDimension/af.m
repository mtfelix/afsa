#! /usr/bin/octave
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
## Author: LaySent <laysent@gmail.com>
## Keywords: Artificial Fish Algorithm
## Created: 2012-08-12

%function [ ret ] = af ()

% algorithm start

% clean the screen
clc;
clear;
% 计时开始
tic;
% clean log files
%system("mkdir -p log");
%system("rm -v log/*");

% turn on the debug mode
debug_on_warning (1);
% parameter initialization

% training set is stored in file data.mat with the name of data
%load data.mat;
load ex7data2.mat;
global data = X;

global tryNumber = 3;
global step = 0.8;
global visual = 2.5;
global jamming = 0.0526;
global iter = 0;
global gFoodCount = 0;
ansBoard = -inf;
positionBoard = ones(%size(data)(2)
             1, size(data)(2)) .* (-inf);
fishNum = 15;

% initial fish position by random 
global position = rand(%size(data)(2)
        fishNum, size(data)(2))*20-10;
tmpPosition = zeros(%size(data)(2)
            fishNum, size(data)(2));
global food = zeros(1, fishNum);
tmpFood = zeros(1, fishNum);
% calculate the food of position
% TODO: let getFood function able to accept matrix
for i = 1: fishNum
    food(i) = getFood(position(i,:));
endfor
%checkFood(-10,10,1);

% Initialize the Union Find Part
global unionFind = UF_Create(fishNum);

% check the initialization
%plotFigure(position, food);

minClass = fishNum;
global stepsOfPrey = zeros(fishNum , 1);
% main loop
while(condition() == 1)

  for i = 1:fishNum
    choice = 1;

%    fileName = strcat("log", num2str(i));
%    fid = fopen(strcat("log/",fileName), "a+");
    while (choice <= 5)
      switch(choice)
    % the order of follow
	case 1
%	     printf("%d follow\n",i);
          [tmpFood(i), tmpPosition(i, :)] = follow(i);
    % the order of prey
	case 3
	  %printf("%d prey\n",i);
          [tmpFood(i), tmpPosition(i,:)] = prey(i);
	case 2
	% the order of swarm
	case 6
          [tmpFood(i), tmpPosition(i,:), unionFind, stepsOfPrey] = \
          swarm(position(i,:), position, tryNumber, step,
		visual, jamming, unionFind, i, stepsOfPrey,data);
	% the order of random move
	case 4
          tmpPosition(i,:) = getNewPosition(position(i,:));
          tmpFood(i) = getFood(tmpPosition(i,:));
          if stepsOfPrey(i, 1) >= 3
            UF_Break(i);
            stepsOfPrey(i, 1) = 0;
          else
            stepsOfPrey(i, 1) += 1;
          endif
	% here means: use random move and didn't get a good result
	case 5
	%        printf("iter(%d):%d\n",i,choice);
	% just in case
	otherwise
          printf("The Switch Operation Occurs Some Trouble\n");
      endswitch
      if tmpFood(i) <= food(i)
        choice += 1;
      else
%        printf("iter(%d):%d\n",i,choice);
%        fprintf(fid, "choice %d", choice);
%        fprintf(fid, " --> position %f %f \n", tmpPosition(i,:));
        break;
      endif

    endwhile
%        fclose(fid);

  endfor
  if ansBoard < max(tmpFood)
    [ansBoard, ansBoardIndex] = max(tmpFood);
    positionBoard = tmpPosition(ansBoardIndex,:);
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

%fileName = "logFinal";
%fid = fopen(strcat("log/",fileName), "w");
%fprintf(fid, "Full position matrix: \n");
%fprintf(fid, "%f %f \n", position');
%fclose(fid);

% output final answer
printf("Board = %f\n",ansBoard);
printf("Boardx = %f\n", positionBoard);
printf("Iter = %f\n",iter);
printf("gFoodCount = %f\n",gFoodCount);
% 计时结束
toc;

% draw some figure
plotFigure(position, food);

% check UF result
[result, num] = UF_Check();
printf("Class = %d\n", size(result)(1));
result'
unionFind

% 以下代码检查fish被分类的情况, 并计算出中心位置
% 仅作debug使用
c = plotClass()

plot(data(:,1),data(:,2),'o');
hold on;
for i = 1:size(c)(1)
    plot(c(i,1),c(i,2),'r*');
endfor
hold off;
pause();

% 以下代码主要检查data被实际聚类的情况
% 仅作debug使用
for i = 1:size(c)(1)
    plotData = [];
    for j = 1:size(data)(1)
	flag = 1;	
	for k = 1:size(c)(1)
	    if k == i
	       continue;
	    endif
	    if getDistance(c(i,:), data(j,:)) > getDistance(c(k,:),data(j,:))
	       flag = 0;
	       break;
	    endif
	endfor
	if flag == 1
	   plotData = [plotData; data(j,:)];
	endif
    endfor
    plot(data(:,1),data(:,2),'o');
    hold on;
    plot(c(i,1),c(i,2),'g*');
    if ~isempty(plotData)
      plot(plotData(:,1),plotData(:,2),'ro');
    endif
    hold off;
    pause();
endfor
%endfunction
