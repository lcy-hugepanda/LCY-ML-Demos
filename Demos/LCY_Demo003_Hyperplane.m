%% Demo of Hyperplane in 3-Dimension
%
% This demo illustrates the hyperplane in 3-Dimension
%

% This file is a part of LCY-ML-Demos (https://github.com/lcy-hugepanda/LCY-ML-Demos)
% Copyright: LCY-Hugepanda (www.lovecaoying.com)
% Last updated: 2013-12-30 23:10:49

% Based on PRTools5 (www.37steps.com)
% PRTools5 Copyright: Robert P.W. Duin (prtools@rduin.nl)

A = gauss([10 10],[-2,-2, -2; 1 1 1]);
scatterd(A,3)
hold on
A=2; B=4; C=-3; D=2;
[xx,yy]=meshgrid(-5:1:5,-5:1:5);
zz=(-D-A*xx-B*yy)/C;
surf(xx,yy,zz,'facealpha',0.8); 
shading interp;
axis auto
grid on