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

## plotFigure

## Author: reAsOn <reason@For-Napkin>
## Author: LaySent <laysent@gmail.com>
## Created: 2012-08-26

function [] = plotFigure (position, food)

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
      plot(position(:,1)', position(:,2)',"*");
      pause();
%      pause();
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

endfunction