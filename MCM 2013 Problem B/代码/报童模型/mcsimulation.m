clc; clear all; close all;

mean = 1152;
stdev = 440;
s = 0.005344;
c = 0.022243;
optimal = 841;

nums = 500;
tc = zeros(1, nums);
r0 = randn(1, nums);
r = r0*stdev+mean;
r(r<0) = [];
tc = c*(optimal-r).*(optimal>=r)+s*(r-optimal).*(r>optimal);

x = 0:0.01:3000;
y = 1/(stdev*sqrt(2*pi))*exp(-(x-mean).*(x-mean)/(2*stdev*stdev));

% bar (r,tc)
% hold on
[AX,H1,H2] = plotyy(r,tc,x,y)
set(get(AX(1),'Ylabel'),'String','Left Y-axis')
set(get(AX(2),'Ylabel'),'String','Right Y-axis')
set(H1,'LineStyle','*')
set(H2,'LineStyle','-')
% plot(x,y)
axis([0,3000])