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

## plot_cluster

## Author: reAsOn <reason@For-Napkin>
## Author: LaySent <laysent@gmail.com>
## Created: 2012-08-26

function [] = plot_cluster (position, food, iter)

  if size(position)(2) == 1
    plot(position, food, "*");
    tmp = -10:0.1:10;
    tmpy = zeros(1,length(tmp));
    for i=1:length(tmp)
      tmpy(i) = getFood(tmp(i));
    endfor
    hold on;
    plot(tmp,tmpy);
    hold off;

%    hold on;
%    tmp = -10:0.01:10;
%    plot(tmp, getFood(tmp));
%    hold off;
    

    % Stop for Observation
    printf("Figure Done. Press ENTER to continue\n");
    pause();

  else
    # TODO: code for 2-Dimension and higher
    if size(position)(2) == 2      
      plot(0,10,"-");
      hold on;
      plot(position(:,1)', position(:,2)',"*");
      plot(0, 0,"-");
      hold off;
      pause();
%      load ex7data2.mat;
%      hold on;
%      for i = 1:size(X)(1)
%	printf("%d\tDONE\n",i);
%	fflush(stdout);      
%	plot(X(i,1),X(i,2),"*");
%      endfor
%      hold off;
    else
      printf("Dimension is NOT 1, draw the figure is NOT supported\n");
    endif
  endif

%% ========== 输出并查集的结果 ==========
%
  [result, num] = UF_Check();
  printf("Class = %d\n", size(result)(1));

%% 以下代码检查fish被分类的情况, 并计算出中心位置
%% NOTE:
%  程序时间复杂度未经优化, 仅作debug使用
  c = plotClass();

%% 以下代码输出各个几何的中心点位置
%  中心点定义为一个集合中食物浓度最大的点
%
  global data;
  plot(data(:,1),data(:,2),'o');
  hold on;
  for i = 1:size(c)(1)
    plot(c(i,1),c(i,2),'r*');
  endfor
  hold off;
  pause();
  
%% 以下代码主要检查data被实际聚类的情况
%% NOTE:
%  程序时间复杂度未经优化, 仅作debug使用
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

endfunction
