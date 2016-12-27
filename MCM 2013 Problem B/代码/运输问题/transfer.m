clear all; clc; close all;

%读取成本矩阵
c = xlsread('cost.xlsx');
[rows, cols] = size(c);

%读取缺口
supplydemand = xlsread('supplydemand.xlsx');

%处理供需数据
a = supplydemand(:, 1);
a(isnan(a)) = [];
b = supplydemand(:, 2);
b(isnan(b)) = [];
totala = sum(a);
totalb = sum(b);

E = totala - totalb;

x = zeros(rows, cols);

% if(E==0)
%     Aeq = ;
%     beq = [a; b];
%     LB = zeros(1, rows*cols);
%     [x, fval] = linprog(c, [], [], Aeq, beq, LB);
% elseif (E>0)   %供应大于需求
%     Aeq = ;
%     beq = [a; b];
%     LB = zeros(1, rows*cols);
%     [x, fval] = linprog(c, [], [], Aeq, beq, LB);                                                                                                                                                                                                                   
% else           %供应小于需求
%         [x, fval] = linprog();
% end



