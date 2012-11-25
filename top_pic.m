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

%global data;

%% tryNUmber表示prey执行的最高次数
global tryNumber = 3;

%% step表示步长
global step = 15;

%% visual为视阈
global visual = 40;

%% jamming是拥挤因子
global jamming = 0.1;

%% fishNum是鱼的数量
global fishNum = 64;

%% maxIter是迭代的上限
global maxIter = 50;

%% defineRange是定义域
global defineRange = [0, 255;
		      0, 255;
		      0, 255];

%% gFoodCount变量用于存储getFood函数被调用的次数
%  仅在需要调试的时候使用
%
global gFoodCount = 0;

%% ========== 定义调用方式 ==========
%
%% 定义使用的food函数
global getFood = @food_pic;

%% 定义使用的plot函数
global plotFigure = @plot_pic;

%% 定义判定收敛方式
global condition = @condition_cluster;

%% 定义是否调用uf
global feature_uf = 1;

%% 定义debug级别
%% ===== debug级别 =====
%  0. 无debug信息输出
%  1. 输出迭代次数和最后的图像
%  2. 输出每步的迭代图像和鱼的运动类别选择
global debug_level = 1;

%% 定义初始化方式
%  1. 随机分布
%  2. 等距分布
global initial_type = 1;

A = double(imread('bird_small.png'));
global img_size = size(A);

global data = reshape(A, img_size(1) * img_size(2), 3);

%% 调用函数
af();
