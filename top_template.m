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

## top_template

## Author: reAsOn <reason@For-Napkin>
## Created: 2012-11-22

clear;
%% 打开debug模式
debug_on_warning (1);

%% ==================== 参数配置 ====================
%

global data;
if isempty(data)
   load ex7data2.mat;
   data = X;
endif

%% tryNUmber表示prey执行的最高次数
global tryNumber;
if isempty(tryNumber)
   tryNumber = 3;
endif

%% step表示步长
global step;
if isempty(step)
   step = 0.5;
endif

%% visual为视阈
global visual;
if isempty(visual)
   visual = 2.5;
endif

%% jamming是拥挤因子
global jamming;
if isempty(jamming)
  jamming = 0.1;
endif

%% iter是已经迭代的步数
global iter = 0;

%% fishNum是鱼的数量
global fishNum;
if isempty(fishNum)
  fishNum = 16;
endif

%% maxIter是迭代的上限
global maxIter;
if isempty(maxIter)
  maxIter = 10;
endif

%% defineRange是定义域
global defineRange;
if isempty(defineRange)
  defineRange = [-3, 3; -3, 3];
endif

%% gFoodCount变量用于存储getFood函数被调用的次数
%  仅在需要调试的时候使用
%
global gFoodCount = 0;

%% ========== 定义调用方式 ==========
%
%% 定义使用的food函数
global getFood;
% 聚类函数
%getFood = @cluster_food;
% 一维函数
%getFood = @one_dim_func;
% 二维函数
getFood = @peaks_func;

%% 定义使用的plot函数
global plotFigure;
% 聚类函数
%plotFigure = @plot_cluster;
% 一维函数
%plotFigure = @plot_one_dim;
% 二维函数
plotFigure = @plot_two_dim;

%% 定义是否调用uf
global feature_uf = 0;

%% 调用函数
af();
