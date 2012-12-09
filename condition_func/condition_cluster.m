##

## -*- texinfo -*-
## @deftypefn {Function File} {} condition ()
## 判断人工鱼群算法是否已经达到收敛要求, 主要有以下两种判定方式:
## 1. 迭代是否达到迭代上限
## 2. 鱼群是否已经收敛
## 
## 程序没有传入参数, 返回值为0或1. 其中0代表运行可以结束, 1代表运行未达到要求
##
## @seealso{af}
## @end deftypefn

## Author: LaySent

function [ret] = condition_cluster()
%% ========== 声明全局变量 ==========
%
  global iter;           % 已迭代的次数
  global ansBoardIndex;  % 最大值的鱼下标
  global position;       % 鱼群位置
  global visual;         % 视域
  global fishNum;        % 鱼群数量
  global maxIter;        % 最大迭代次数上限
  global feature_uf;
  global unionFindNum;

%% 以下部分仍然不能正确运作
  persistent classNumMin;
  persistent continueNum;
  persistent sign;

%% ansBoardIndex仅在初始化时为-1
  if ansBoardIndex == -1
    classNumMin = fishNum;
    continueNum = 0;
    sign = 0;
    ret = 1;
%% 若不为初始情况, 则需要考虑两个方面
%  1. 迭代次数是否达到上限
%  2. 是否已经收敛
  else
    if iter < maxIter
%% TODO:
%  判断收敛方式
       epsilon = 1.1;
       [num, idx] = uf_check(mod(iter, unionFindNum)+1);
       size(num)(1)

       if size(num)(1) >= classNumMin
	  if abs(classNumMin - size(num)(1)) < epsilon
	    continueNum += 1;
	  else
	    continueNum = 0;
	  endif
       else
	   classNumMin = size(num)(1);
	   continueNum = 0;
       endif
       if continueNum == 10
	  sign = 1;
       endif
       if sign == 1 && size(num)(1) == classNumMin
	 ret = 0;
       else
	 ret = 1;
       endif
       return;
%% 以下部分仍然不能正确运作
#      [num, idx] = UF_Check();
#      if classNum == size(num)(1)
#	 continueNum += 1;
#      else
#	classNum = size(num)(1);
#      endif
#      if continueNum >= 4
#	ret = 0;
#      else
#
#	ret = 1;
#      endif
#       ret = 1;
    else
%% 若达到迭代上限, 则结束程序
      ret=0;
    endif % if iter < maxIter

  endif   % if ansBoardIndex == -1

endfunction
