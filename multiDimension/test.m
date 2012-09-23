clc;

a = 1000;

for i = 999:-1:1
  a = (1/(i + 1) - a) / 10;
endfor
a