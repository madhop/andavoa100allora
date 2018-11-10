% PERVASIVE
close all
clear
clc


% tempo, x, y, z
% tempo, latitudine, longitudine
%% read data
data = readtable('162736.csv');
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
plot( acc_data(:,4));
hold on
plot(lowpass(acc_data(:,4),0.001))

%%
height = mean(acc_data(:,4));
norm_data = acc_data(:,4) - height;

var = abs(norm_data).^2;
subplot(2,1,1)
plot(norm_data)
subplot(2,1,2)
plot(lowpass(var,0.001));