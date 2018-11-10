% PERVASIVE
close all
clear
clc


% tempo, x, y, z
% tempo, latitudine, longitudine
%% read data
data = readtable('160208.csv'); %104107 %162736 %110122
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
plot( acc_data(:,7));
% plot(data{:,2});
% hold on
% plot( lowpass(acc_data(:,4), 0.000001));
% hold off

%% STIMA DELAY GPS
% delay = [];
% for i=2:size(data,1)
%     if strcmp(data{i,1}, 'GPS')
%         delay = [delay,data{i,2} - data{i-1,2}];
%     end
% end
%% SCINDERE X,Y,Z
