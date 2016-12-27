clc; clear all; close all;

mean = 1152;
stdev = 440;
s = 0.005344;
c = 0.022243;
optimal = 841;

% consider stock-out cost &holding host change 80%~120%
s = s*0.8:0.03*s:s*1.2;
c = c*0.8:0.03*c:c*1.2;

[s, c] = meshgrid(s, c);
pnums = size(s,2);
tc = zeros(pnums, pnums);

syms r;

for i=1:pnums
    for j=1:pnums
    
    %using the Gauss Distribution to find the optimal solution, given s(i, j)&c(i, j)
    ratio = s(i, j)/c(i, j);
    optimal = norminv(ratio, mean, stdev);
    
     tc(i, j) = double(int(c(i, j)*(optimal-r)*1/(stdev*sqrt(2*pi))*exp(-(r-mean)*(r-mean)/(2*stdev*stdev)), r, 0, optimal)+...
        int(s(i, j)*(r-optimal)*1/(stdev*sqrt(2*pi))*exp(-(r-mean)*(r-mean)/(2*stdev*stdev)), r, optimal, inf));
   
    end
end

% plot sensitivity graph
h = surf(s, c, tc);




