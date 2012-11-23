#! /usr/bin/octave -qf
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

function [ ret ] = af()
%% ==================== 初始配置 ==================== 
%  以下代码用于进行程序运行环境的初始配置
% 

%% 清理运行环境
clc;
%clear;%close all;

% 声明全局变量
global data;
global tryNumber;
global step;
global visual;
global jamming;
global iter;
global fishNum;
global maxIter;
global defineRange;
global gFoodCount;
global getFood;
global plotFigure;
global feature_uf;

%% ========== 初始化鱼群分布 ==========
%  初始化的方式主要有两种
%  一种是随机分布
%  一种是均匀分布(非以概率分布)
%  以下提供两种选择方案, 可按需要进行选择
%% NOTE:
%  目前以下两种方式都不是直接根据一个变量值来决定定义域的大小
%  需要改进
%

%% 以下使用随机分布
%global position = rand(%size(data)(2)
%        fishNum, size(data)(2));

%% 以下使用均匀分布(非以概率分布)
%  generateGrid函数的使用说明见该文件
%
global position = generateGrid(defineRange, (fishNum).^(1/size(defineRange)(1)));

%% ========== 初始化食物浓度值 ==========
%  NOTE: 
%  目前仅函数最值查找的getFood函数可以接受矩阵形式
%

%% 初始化分配空间
global food = zeros(1, fishNum);
%% 根据坐标位置计算每一条人工鱼的当前食物浓度
for i = 1: fishNum
    food(i) = getFood(position(i,:));
endfor

%% tmpPosition用于存放当前迭代步骤下的鱼坐标
%  用于在一次迭代完成后一并更改所有鱼的坐标位置
%% NOTE:
%  如果程序改成每条鱼执行一次运动就修改position的变量,
%  那么tmpPosition不再需要
tmpPosition = zeros(fishNum, size(position)(2));

%% tmpFood用于存放当且迭代步骤下鱼坐标对应的食物浓度
%  用于在一次迭代完成后一并更改所有鱼的坐标位置
%% NOTE:
%  如果程序改成每条鱼执行一次运动就修改food的变量,
%  那么tmpFood不再需要
tmpFood = zeros(1, fishNum);

%% ========== 设置公告板相关变量 ==========
%

%% ansBoard变量为公告版
%  用于存放当前所得的最优解,初始存放负无穷,保证比任何数小
%
ansBoard = -inf;

%% positionBoard变量用于存放最优解的坐标位置
%  初始设置为负无穷,保证可以比任何数小
%
positionBoard = ones(1, size(position)(2)) .* (-inf);

%% ansBoardIndex保存最大值所在鱼的编号
%  仅当算法不改变最大值鱼的位置时有如此设置的必要
%  此处改进参考了以下论文
%  [1] Color Quantization Using Modified Artificial Fish Swarm Algorithm
%  此处初始设置为-1, 保证在第一次循环时不会发生意外
%
global ansBoardIndex = -1;

%% ========== 初始化并查集 ==========
%  具体的代码参见UF_Create函数的相关说明
%
global unionFind;
if feature_uf
  unionFind = UF_Create(fishNum);
endif

%% 为stepsOfPrey变量分配空间
%  改变量的作用是记录已经连续执行了几次Prey操作
%
global stepsOfPrey;
if feature_uf
  stepsOfPrey = zeros(fishNum , 1);
endif

%% maxPreyNum指定了最多执行的prey次数
%  一旦连续执行超过maxPreyNum次数的prey
%  则执行一次UF_Break
%  此处这样规定的主要用意在于避免收敛的情况下
%  由于局部极值无发找到更好的解而执行prey运动
%  而被执行了不必要的UF_Break操作
%
global maxPreyNum;
if feature_uf
  maxPreyNum = 3;
endif

%% 以下查看初始化情况
%  仅在debug时用于查看, 一般不需执行
%plotFigure(position, food);

%% ==================== 程序开始 ====================
%

%% 以下开始计时
tic;

%% ========== 程序的主循环如下 ==========
%  其中condition函数用于判断是否收敛
%  
while(condition() == 1)

%% ========== 依次计算每一条人工鱼 ==========
%
  for i = 1:fishNum

%% 若为当前的最优解, 则该鱼不动
%  此处改进参考了[1]
    if i == ansBoardIndex
%% 调试信息
%       printf("iter(%d) skipped\n", i);
%       continue;
    endif

%% choice变量用于计算下一步要执行的运动方式
    choice = 1;
    
%% ========== 说明 ==========
%  运动方式的调用顺序如下:
%  1. follow
%  2. swarm
%  3. prey
%  4. 暂时为空
%  5. 用于调试
%  6. 暂时为空
%  7. random move
%  其他(不会被执行)
%
    while (choice <= 5)
      switch(choice)
%% ========== 执行follow ==========
%  执行顺序为1
	case 1
          [tmpFood(i), tmpPosition(i, :)] = follow(i);

%% ========== 执行swarm ==========
%  执行顺序为2
%
	case 2
          [tmpFood(i), tmpPosition(i,:)] = swarm(i);

%% ========== 执行prey ==========
%  执行顺序为3
	case 3
          [tmpFood(i), tmpPosition(i,:)] = prey(i);

%% case 6实际上不会被执行
	case 6
% 这是一条空语句, case 6未执行任何代码

	case 4
%% 这是一条空语句, case 4未执行任何代码
	     
%% ========== 执行random move ==========
%  执行顺序为7(本语句不会被执行)
%% NOTE:
%  random move已和prey进行合并
%
	case 7
          tmpPosition(i,:) = getNewPosition(position(i,:));
          tmpFood(i) = getFood(tmpPosition(i,:));
	  if feature_uf
            if stepsOfPrey(i, 1) >= maxPreyNum
              UF_Break(i);
              stepsOfPrey(i, 1) = 0;
            else
              stepsOfPrey(i, 1) += 1;
            endif
	  endif

%% ========== 执行调试语句 ==========
%  执行顺序为5
%  case 5的语句仅在执行prey且也没有得到合适的值时执行
%
	case 5
%% 输出调试语句
%	  printf("iter(%d):%d\n",i,choice);

%% ========== 以防万一 ==========
%  其他情况(理应执行不到这句语句)
%
	otherwise
          printf("The Switch Operation Occurs Some Trouble\n");
      endswitch

%% 若当前执行方式不能得到更好的解
%  则继续执行下一种运动方式
      if tmpFood(i) <= food(i)
        choice += 1;
      else
%% 输出一点调试信息
%  查看每条鱼最终执行的运动方式(需配合case 5一起使用)
%        printf("iter(%d):%d\n",i,choice);
        break;
      endif  % if tmpFood(i) <= food(i)

    endwhile % while (choise <= 5)

%% ========== 更新鱼群信息 ==========
%  此处表示每执行一步便进行更新
%
  position(i, :) = tmpPosition(i, :);
  food(i) = tmpFood(i);

  endfor     % for i = 1 : fishNum

%% ========== 更新公告版 ==========
%
  if ansBoard < max(tmpFood)
    [ansBoard, ansBoardIndex] = max(tmpFood);
    positionBoard = tmpPosition(ansBoardIndex,:);
  endif

%% ========== 更新鱼群信息 ==========
%  此处表示一次迭代完成后一次性更新全部信息
%  position = tmpPosition;
%  food = tmpFood;
    

%% ========== 一次迭代结束 ==========
%  以下代码实现:
%% 1. 迭代数加一
  iter = iter + 1;
%% 2. 输出一些迭代信息 
%  这里用fflush(stdout)保证本函数即使被其他函数调用,也可以正确显示迭代信息
%  若不写这句, 当函数被其他程序调用时, 需要等待程序运行完成才会一次性输出
%
  printf("Iteration %d DONE\n",iter);
  fflush(stdout);

%% 输出每次迭代后的鱼群分布
%  plotFigure(position, food);

endwhile  % while(condition() == 1)

%% 计时结束
toc;

%% ==================== 以下输出运行结果 ====================
%  
printf("Board = %f\n",ansBoard);
printf("Boardx = %f\n", positionBoard);
printf("Iter = %f\n",iter);
printf("gFoodCount = %f\n",gFoodCount);

%% 输出图像
plotFigure(position, food);

%% ========== 输出并查集的结果 ==========
%
if feature_uf
  [result, num] = UF_Check();
  printf("Class = %d\n", size(result)(1));
endif

%% 以下代码检查fish被分类的情况, 并计算出中心位置
%% NOTE:
%  程序时间复杂度未经优化, 仅作debug使用
c = plotClass();

%% 以下代码输出各个几何的中心点位置
%  中心点定义为一个集合中食物浓度最大的点
%
if feature_uf
  plot(data(:,1),data(:,2),'o');
  hold on;
  for i = 1:size(c)(1)
    plot(c(i,1),c(i,2),'r*');
  endfor
  hold off;
  pause();
endif
clear;
%% 以下代码主要检查data被实际聚类的情况
%% NOTE:
%  程序时间复杂度未经优化, 仅作debug使用
%for i = 1:size(c)(1)
%    plotData = [];
%    for j = 1:size(data)(1)
%	flag = 1;	
%	for k = 1:size(c)(1)
%	    if k == i
%	       continue;
%	    endif
%	    if getDistance(c(i,:), data(j,:)) > getDistance(c(k,:),data(j,:))
%	       flag = 0;
%	       break;
%	    endif
%	endfor
%	if flag == 1
%	   plotData = [plotData; data(j,:)];
%	endif
%    endfor
%    plot(data(:,1),data(:,2),'o');
%    hold on;
%    plot(c(i,1),c(i,2),'g*');
%    if ~isempty(plotData)
%      plot(plotData(:,1),plotData(:,2),'ro');
%    endif
%    hold off;
%    pause();
%endfor
endfunction
