clear all; close all; clc;

forecastscale = 27;   %设定总的时间跨度，包括历史数据和预测数据年分数
input = xlsread('waterhistorysupply.xlsx'); % input = numberofcities*numberofyears

[numberofcities, numberofyears] = size(input); %返回省的数量和历史数据年份数

cumsuminput = cumsum(input')'; %返回累计求和

%计算累计平均矩阵 B = numberofcities*(numberofyears-1)
for i=1:numberofcities
    for j=1:numberofyears-1
        B(i,j) = 0.5*(cumsuminput(i, j)+cumsuminput(i, j+1));
    end
end

% 计算待定参数的值
for i=1:numberofcities
    D = input(i,:);
    D(1) = [];
    D = D';
    E = [-B(i,:); ones(1,numberofyears-1)];
    c = inv(E*E')*E*D;
    c = c';
    a = c(1);
    b = c(2);
    %得到预测后每年的累计数据
    F(i,:) = zeros(1, forecastscale);
    F(i,1) = cumsuminput(i, 1);
    for j=2:forecastscale
        F(i, j) = (input(i, 1) - b/a)/exp(a*(j-1))+b/a;
    end
    G(i, :) = zeros(1, forecastscale);
    G(i, 1) = input(i, 1);
    %得到预测后每年的数据
    for j=2:forecastscale
        G(i,j) = F(i, j) - F(i, j-1); 
    end
end

%初步的绘图
t1 = 1999:(1999+numberofyears-1);
t2 = 1999:(1999+forecastscale-1);
plot(t1, input, 'o', t2, G)

%保存数据到waterdemandforecast.xlxs
xlswrite('waterforecastsupply.xls', G)









