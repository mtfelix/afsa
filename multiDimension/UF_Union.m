# this time the order of p and q are really IMPORTANT
function [list, gFoodCount] = UF_Union(list, fish, p, q, iter,data, \
				       gFoodCount, food)
#  printf("Union (%d,%d)\n",p,q);
  if iter <=28
    list = UF_Break(list, fish, p);
  endif
  i = UF_Find(list, p);
  j = UF_Find(list, q);
  if i != j
    if size(fish(i,:))(2) == 1
      printf("size(fish) == 1\n\twhere i = %d\n",i);
    endif
    if size(fish(j,:))(2) == 1
      printf("size(fish) == 1\n\twhere i = %d\n",j);
    endif
    if getFood(fish(i,:),data) < getFood(fish(j,:),data)
%    if food(i) < food(j)
      list(i) = j;
    else
      list(j) = i;
    endif
    gFoodCount+=2;
  endif
endfunction
