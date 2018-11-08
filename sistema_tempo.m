% sistemare tempo
close all
clear
clc
%% 
data = readtable('104107.csv');


for i=1:size(data,1)
    if strcmp(data{i,1}, 'ACC')
        acc_data = [acc_data; data(i,2:8)];
    else
        gps_data = [gps_data; data(i,2:4)];
    end
end