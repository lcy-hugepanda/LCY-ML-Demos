%% Demo of Simplest Perceptron
%
% This demo illustrates the training of perceptron learning algorithm on a
% 2-D toy dataset.
%

% This file is a part of LCY-ML-Demos (https://github.com/lcy-hugepanda/LCY-ML-Demos)
% Copyright: LCY-Hugepanda (www.lovecaoying.com)
% Last updated: 2013-12-26 17:39:40

% Based on PRTools5 (www.37steps.com)
% PRTools5 Copyright: Robert P.W. Duin (prtools@rduin.nl)

A = gauss([20 20],[-2,-2; 1 1]);
scatterd(A);
hold on 
W = DemoPercaptron(A,[],'pocket');
gridsize(100)
plotc(W);