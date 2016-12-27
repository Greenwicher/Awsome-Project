clc; clear all; close all;
load china;
plot(province.long, province.lat, 'color', [0.7, 0.7, 0.7])
hold on
plot(border.long, border.lat, 'color', [0.5, 0.5, 0.5], 'linewidth', 1.5);

h = plot(NaN, NaN, 'b-', 'linewidth', 1);

plot([city(2:end).long], [city(2:end).lat], 'o', 'markersize', 3, ...
                              'MarkerEdgeColor','b','MarkerFaceColor','g');

plot([city(1).long], [city(1).lat], 'p','markersize',5, ...
                              'MarkerEdgeColor','r','MarkerFaceColor','g');
axis([70 140 15 55]);