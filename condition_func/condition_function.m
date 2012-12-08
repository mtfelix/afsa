##

## -*- texinfo -*-
## @deftypefn {Function File} {} condition ()
## 判断人工鱼群算法是否已经达到收敛要求, 主要有以下两种判定方式:
## 1. 迭代是否达到迭代上限
## 2. 鱼群是否已经收敛
##nn 
## 程序没有传入参数, 返回值为0或1. 其中0代表运行可以结束, 1代表运行未达到要求
##
## @seealso{af}
## @end deftypefn

## Author: LaySent

function [ret] = condition_function()
%% ========== 声明全局变量 ==========
%
  global iter;           % 已迭代的次数
  global ansBoardIndex;  % 最大值的鱼下标
  global position;       % 鱼群位置
  global visual;         % 视域
  global fishNum;        % 鱼群数量
  global maxIter;        % 最大迭代次数上限
  global feature_uf;

%% ansBoardIndex仅在初始化时为-1
  if ansBoardIndex == -1
    ret = 1;
%% 若不为初始情况, 则需要考虑两个方面
%  1. 迭代次数是否达到上限
%  2. 是否已经收敛
  else
    if iter < maxIter
%% ========== 判断是否收敛 ==========
%  判断的方式如下
%  若最大值附近邻域内鱼群数量达到要求, 则判断为收敛
%% NOTE:
%  以下判断方式仅适用于极值问题, 不适用于聚类问题
% 
      friends = 0;
      for i = 1:size(position)(1)
%% 不考虑最大值点
%  这里ansBoardIndex存储的是最大值点的下标
	if i == ansBoardIndex
	  continue;
	endif

%% 判断是否在领域内
	if getDistance(position(ansBoardIndex,:), position(i,:)) <= visual
	  friends += 1;
	endif

      endfor

%% 判断邻域内的鱼群数量是否达到收敛要求
%  达到要求返回0
%  未达到要求返回1
      if friends >= fishNum / 2
	ret = 0;
      else
	ret = 1;
      endif

    else
%% 若达到迭代上限, 则结束程序
      ret=0;
    endif % if iter < maxIter

  endif   % if ansBoardIndex == -1

endfunction
