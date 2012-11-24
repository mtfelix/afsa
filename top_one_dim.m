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
global step = 0.5;

%% visual为视阈
global visual = 2.5;

%% jamming是拥挤因子
global jamming = 0.1;

%% fishNum是鱼的数量
global fishNum = 16;

%% maxIter是迭代的上限
global maxIter = 10;

%% defineRange是定义域
global defineRange = [-10, 10];

%% gFoodCount变量用于存储getFood函数被调用的次数
%  仅在需要调试的时候使用
%
global gFoodCount = 0;

%% ========== 定义调用方式 ==========
%
%% 定义使用的food函数
global getFood = @food_one_dim;

%% 定义使用的plot函数
global plotFigure = @plot_one_dim;

%% 定义是否调用uf
global feature_uf = 0;

%% 定义debug级别
%% ===== debug级别 =====
%  0. 无debug信息输出
%  1. 输出迭代次数和最后的图像
%  2. 输出每步的迭代图像和鱼的运动类别选择
global debug_level = 0;

%% 调用函数
af();
