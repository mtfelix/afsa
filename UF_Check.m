%% ==================== 说明 ====================
%  本函数主要用于统计总共有几个集合
%
function [ret, num] = UF_Check()
%% ========== 声明全局变量 ==========
%
  global unionFind

%% num存放集合的下标
  num = [];
%% ret存放各个集合的元素个数
  ret = [];

%% 以下暴力搜索全部的元素
  for i = 1:size(unionFind)(2)
%% 获取第i个元素所在集合的下标
    tmp = UF_Find(i);    

    boolean = 1;

%% 如果第i个元素所在的集合已经被记录在num中了, 则ret中对应的值加1
    for j = 1:size(ret)(1)
      if UF_Find(num(j,1)) == tmp
	ret(j,1) += 1;
%% boolean == 0 表示该元素所在集合不是一个新集合
	boolean = 0;
	break;
      endif
    endfor

%% 如果是一个新集合(即 boolean == 1)
%  则把信息加入到返回值中
    if boolean
      num = [num; tmp];
      ret = [ret; 1];
    endif

  endfor  % for j = 1:size(unionFind)(2)

endfunction
