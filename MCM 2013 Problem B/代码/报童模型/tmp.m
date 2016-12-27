clc; clear all;

q = 841;
mean = 1152;
stdev = 440;
s = 0.005344;
c = 0.022243;
optimal = 841;

syms r;
f1 = c*(841-r)*1/(stdev*sqrt(2*pi))*exp(-(r-mean)*(r-mean)/(2*stdev*stdev));
f2 =s*(r-841)*1/(stdev*sqrt(2*pi))*exp(-(r-mean)*(r-mean)/(2*stdev*stdev));
tc = int(f1, r, 0, 841)+int(f2, r, 841, inf);
    
tc

