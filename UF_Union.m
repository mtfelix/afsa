# this time the order of p and q are really IMPORTANT
function [] = UF_Union(p, q)
#  printf("Union (%d,%d)\n",p,q);
  global gFoodCount;
  global food;
  global unionFind;
  global position;
  global iter;
  global data;
  if iter <=28
    UF_Break(p);
  endif
  i = UF_Find(p);
  j = UF_Find(q);
  if i != j
    if size(position(i,:))(2) == 1
      printf("size(position) == 1\n\twhere i = %d\n",i);
    endif
    if size(position(j,:))(2) == 1
      printf("size(position) == 1\n\twhere i = %d\n",j);
    endif
    if getFood(position(i,:)) < getFood(position(j,:))
%    if food(i) < food(j)
      unionFind(i) = j;
    else
      unionFind(j) = i;
    endif
    gFoodCount+=2;
  endif
endfunction
