% PERVASIVE
close all
clear
clc


% tempo, x, y, z
% tempo, latitudine, longitudine
%% read data
data = readtable('104107.csv');
gps_data = [];
acc_data = [];

for i=1:size(data,1)
    if strcmp(data{i,1}, 'ACC')
        acc_data = [acc_data; data(i,2:8)];
    else
        gps_data = [gps_data; data(i,2:4)];
    end
end

acc_data = table2array(acc_data);
gps_data = table2array(gps_data);
%% 
plot( acc_data(:,1));
