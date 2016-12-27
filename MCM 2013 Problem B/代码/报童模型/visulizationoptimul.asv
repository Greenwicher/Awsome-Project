clc; clear all; close all;

mean = 1152;
stdev = 440;
s = 0.005344;
c = 0.022243;
optimal = 841;

scale = 1500;
q = 1:10:scale;
nums = size(q, 2);
tc = zeros(1, nums);

syms r;
% f1 = c*(q(i)-r)*1/(stdev*sqrt(2*pi))*exp(-(r-mean)*(r-mean)/(2*stdev*stdev));
% f2 =
% s*(r-q(i))*1/(stdev*sqrt(2*pi))*exp(-(r-mean)*(r-mean)/(2*stdev*stdev));

for i=1:nums
    tc(i) = int(c*(q(i)-r)*1/(stdev*sqrt(2*pi))*exp(-(r-mean)*(r-mean)/(2*stdev*stdev)), r, 0, q(i))+...
        int(s*(r-q(i))*1/(stdev*sqrt(2*pi))*exp(-(r-mean)*(r-mean)/(2*stdev*stdev)), r, q(i), inf);
    i
end

plot(q, tc, '-')



