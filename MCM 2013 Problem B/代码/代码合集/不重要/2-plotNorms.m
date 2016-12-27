clc; clear all; close all;

mean = 1152;
stdev = 440;
s = 0.005344;
c = 0.022243;
ratio = s/c;
optimal = norminv(ratio, mean, stdev);

r = 0:0.01:3000;
y = 1/(stdev*sqrt(2*pi))*exp(-(r-mean).*(r-mean)/(2*stdev*stdev));

plot(r,y,'-')
axis([0 3000 0 0.001])
hold on

x = 0:0.1:ceil(optimal);
z = 1/(stdev*sqrt(2*pi))*exp(-(x-mean).*(x-mean)/(2*stdev*stdev));
bar(x, z, 'g')


