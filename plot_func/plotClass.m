function [retCenter] = plotClass()
  global unionFind;
  global position;
  global food;
  global data;
  global unionFindNum;
  global iter;
  [ret, num] = uf_check(mod(iter, unionFindNum) + 1);
  retCenter = [];
  for iter = 1:size(num)(1)
    center = zeros(1, size(position)(2));
    plotData = [];
    maxData = zeros(1, size(position)(2));
    maxFood = -1;   
    for i = 1:size(unionFind)(2)
      if uf_connected(num(iter,1), i, unionFindNum)	 
	plotData = [plotData; position(i,:)];
	if maxFood < food(i)
	   maxData = position(i,:);
	   maxFood = food(i);
	endif
      endif
    endfor
%    printf("This is the class of %d\n", num(iter,1));
    if size(plotData)(1) == 1
      %printf("Skiped\n");
      center = plotData(1,:);
    else
      center = maxData(1,:);
    endif
%    plot(0,0,"-");
%    hold on
%    plot(data(:,1),data(:,2),'o');
%    plot(10,10,"-");
%    plot(position(:,1)', position(:,2)', "*");
%    plot(plotData(:,1)', plotData(:,2)', "2*");
%    plot(center(1),center(2),'r*');
%    hold off
    retCenter = [retCenter;center];
%    pause();
  endfor

endfunction
