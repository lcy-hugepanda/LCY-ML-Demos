% LCY_Demo001_HardMarginTwoClassSVM
% Author: hugepanda @ LCY
% 2013-9-10 15:22:03
 
% Linear Seperable Data in 2-dimension
data1= mvnrnd ( [1,1]*2, eye(2), 20 );
data2= mvnrnd ( [-1,-1]*2, eye(2), 20);

% Quadratic Programming
H = [1 0 0; 0 1 0; 0 0 0];
f = [ 0 0 0];
Ap = -[data1 ones(20,1)];
An = [data2 ones(20,1)];
A = [Ap; An];
b = -ones(40,1);
opt = optimset('Algorithm','active-set');
[w,fval,exitflag,output,lambda] = quadprog(H,f,A,b,[],[],[],[],[],opt);
 
% Visualize Results
scatter(data1(:, 1), data1(:, 2), 'b+', 'SizeData', 200, 'LineWidth', 2);
hold on
scatter(data2(:, 1), data2(:, 2), 'rx', 'SizeData', 200, 'LineWidth', 2);
axis tight
x1 = -6:0.01:6;
plot(x1, (-w(3)-x1*w(1))/w(2), 'k', 'LineWidth', 2);
plot(x1, (1-w(3)-x1*w(1))/w(2), 'k:', 'LineWidth', 1.5);
plot(x1, (-1-w(3)-x1*w(1))/w(2), 'k:', 'LineWidth', 1.5);

% Visualize SVs (Support Vectors)
% dataAll = [data1 ; data2];
% sv_index = find(lambda.ineqlin > 0);
% scatter(dataAll(sv_index, 1), dataAll(sv_index, 2), 'ko', 'SizeData', 200, 'LineWidth', 2);
