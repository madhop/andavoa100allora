% PERVASIVE
close all
clear
clc


% tempo, x, y, z
% tempo, latitudine, longitudine
%% read data
data = readtable('f211118.csv'); %104107 %162736 %110122 %160208 %16111417 %17111738    %f144015 %132038
gps_data = [];
acc_data = [];


for i=1:size(data,1)%1695
    if strcmp(data{i,1}, 'ACC')
        acc_data = [acc_data; data(i,2:8)];
    else
        gps_data = [gps_data; data(i,2:4)];
    end
    
end

acc_data = table2array(acc_data);
gps_data = table2array(gps_data);
%% SOME PLOT
plot(acc_data(:,1), acc_data(:,4));
hold on
plot(acc_data(:,1),lowpass(acc_data(:,4), 0.0000001));
hold off

%% SCINDERE X,Y,Z

%% FFT
Fs = 1000;
L = 10;
Y = fft(acc_data(100:100+L,3));
P2 = abs(Y/L);
P1 = P2(1:L/2+1);
P1(2:end-1) = 2*P1(2:end-1);

f = Fs*(0:(L/2))/L;
plot(f,P1)
title('Single-Sided Amplitude Spectrum of X(t)')
xlabel('f (Hz)')
ylabel('|P1(f)|')

%% VARIANCE
height = mean(acc_data(:,4));
norm_data = acc_data(:,4) - height;

var = abs(norm_data).^2;
subplot(2,1,1)
plot(acc_data(:,1), norm_data)
subplot(2,1,2)
plot(acc_data(:,1), var);
% plot(acc_data(:,1), lowpass(var,0.001));

%% COMPUTE ANGLE FROM GYRO

x_offset = mean(acc_data(1:10,6));
y_offset = mean(acc_data(1:10,7));
z_offset = mean(acc_data(1:10,8));

x_gyro = cumsum(acc_data(11:end,6) * 0.0000611) - x_offset;
y_gyro = cumsum(acc_data(11:end,7) * 0.0000611) - x_offset;
z_gyro = cumsum(acc_data(11:end,8) * 0.0000611) - z_offset;

% pitch = cumsum()
% roll = 


sum(acc_data(1:10,6));