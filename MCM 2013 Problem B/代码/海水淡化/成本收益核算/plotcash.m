clear all; clc; close all;

input = xlsread('cash.xlsx');

[rows, cols] = size(input);

t = 2013:2025; 
color = {'r', 'g', 'b', 'c', 'm', 'y'};
name = {'Beijing', 'Tianjin', 'Shandong Province', 'Jiangsu Province', 'Shanghai', 'Zhejiang Province'};

for i=1: rows 
    flag = char(color(i));
    plot(t, input(i,:), flag, 'LineWidth', 2);
    hold on
    grid on
    legend( 'Beijing', 'Tianjin', 'Shandong Province', 'Jiangsu Province', 'Shanghai')
    xlabel('year')
    ylabel('cash flow (100 million гд)')
    xlim([2012 2026])
    set(gca,'XTick',[2012:1:2026])
end