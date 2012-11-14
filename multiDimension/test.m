clc;

tic;
load ex7data2.mat;
toc;

tic;
data = X;
toc;

tic;
getFood(X(1,:), data)
toc;
