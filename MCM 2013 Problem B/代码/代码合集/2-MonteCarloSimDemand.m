clc; clear all; close all;

% gauss distribution for downstream's water demand of Three Geogres Dam
mean = 1152;
stdev = 440;

% initialize stock-out cost, holding cost and optimal solution
s = 0.005344;
c = 0.022243;
optimal = 841;

% Monte Carlo Simulation
nums = 500;
tc = zeros(1, nums);
r0 = randn(1, nums);
r = r0*stdev+mean;
r(r<0) = [];
tc = c*(optimal-r).*(optimal>=r)+s*(r-optimal).*(r>optimal);

% plot the simulation graph
x = 0:0.01:3000;
y = 1/(stdev*sqrt(2*pi))*exp(-(x-mean).*(x-mean)/(2*stdev*stdev));

[AX,H1,H2] = plotyy(r,tc,x,y)
set(get(AX(1),'Ylabel'),'String','Left Y-axis')
set(get(AX(2),'Ylabel'),'String','Right Y-axis')
set(H1,'LineStyle','*')
set(H2,'LineStyle','-')
axis([0,3000])