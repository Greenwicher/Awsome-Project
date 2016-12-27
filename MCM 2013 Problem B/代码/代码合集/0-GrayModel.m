clear all; close all; clc;

forecastscale = 27;  % time span
input = xlsread('input.xlsx');  %read history data from input.xlsx

[numberofcities, numberofyears] = size(input); 

cumsuminput = cumsum(input')'; 

for i=1:numberofcities
    for j=1:numberofyears-1
        B(i,j) = 0.5*(cumsuminput(i, j)+cumsuminput(i, j+1));
    end
end

for i=1:numberofcities

    D = input(i,:);
    D(1) = [];
    D = D';
    E = [-B(i,:); ones(1,numberofyears-1)];
    c = inv(E*E')*E*D;
    c = c';
    a = c(1);
    b = c(2);

    F(i,:) = zeros(1, forecastscale);
    F(i,1) = cumsuminput(i, 1);
    for j=2:forecastscale
        F(i, j) = (input(i, 1) - b/a)/exp(a*(j-1))+b/a;
    end
    G(i, :) = zeros(1, forecastscale);
    G(i, 1) = input(i, 1);
    
    for j=2:forecastscale
        G(i,j) = F(i, j) - F(i, j-1); 
    end
end

% plot forecast and history data
t1 = 1999:(1999+numberofyears-1);
t2 = 1999:(1999+forecastscale-1);
plot(t1, input, 'o', t2, G)

%save forecast data into result.xls
xlswrite('result.xls', G)
