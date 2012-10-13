function [list] = UF_Union(list, fish, p, q)
#  printf("Union (%d,%d)\n",p,q);
  i = UF_Find(list, p);
  j = UF_Find(list, q);
  if i != j
    if size(fish(i,:))(2) == 1
      printf("size(fish) == 1\n\twhere i = %d\n",i);
    endif
    if size(fish(j,:))(2) == 1
      printf("size(fish) == 1\n\twhere i = %d\n",j);
    endif
    if getFood(fish(i,:)) < getFood(fish(j,:))
      list(i) = j;
    else
      list(j) = i;
    endif
  endif
endfunction
