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
W = DemoPercaptron(A,[],'pocket');
w = W.data.w_archive;
pos = PlotCalculateSubplotPos(3,3);
for i = 2 : 1: 10
    subplot(3,3,i-1,'Position',pos(i-1,:));
    scatterd(A);
    set(gca,'ytick',[]);set(gca,'xtick',[]);xlabel('');ylabel('');title(['epoch ' num2str(i)]);
    hold on 
    x = -4:0.01:3;
    plot(x, 1.0*(-1*w{i}(3)-w{i}(1)*x)/w{i}(2),'k', 'LineWidth',2);
    plot(x, 1.0*(-1*w{i+1}(3)-w{i+1}(1)*x)/w{i+1}(2),'r', 'LineWidth',2);
    update_point = (A.data(W.data.example_update(i),:));
    scatter(update_point(1),update_point(2), 70, 'ko');
end

% gridsize(100)
% plotc(W);