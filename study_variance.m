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
% hold on
% plot(acc_data(:,1),lowpass(acc_data(:,4), 0.0000001));
% hold off

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

%% SPLIT DATA & MERGE
asphalt = iddata(acc_data(891:1833,4),[],0.068);
% d = fix(size(asphalt, 1)/10);
% split_asphalt = {};
% for i=0:8
%     split_asphalt{i+1} = asphalt(i*d + 1:i*d + d);
% end
% split_asphalt{i+2} = asphalt((i+1)*d + 1:end);

split_asphalt{1} = asphalt(1:100);
split_asphalt{2} = asphalt(101:200);
split_asphalt{3} = asphalt(201:300);
split_asphalt{4} = asphalt(301:400);
split_asphalt{5} = asphalt(401:500);
split_asphalt{6} = asphalt(501:600);
split_asphalt{7} = asphalt(601:700);
split_asphalt{8} = asphalt(701:800);



% merge
clear d
d = merge(split_asphalt{1},split_asphalt{2},split_asphalt{3}, split_asphalt{4},split_asphalt{5}, split_asphalt{6}, split_asphalt{7}, split_asphalt{8});

de = getexp(d,[1,2,3,4,5,6,7]);
dv = getexp(d,8);

%% MODEL 
model1 = armax(de, [4 4]);
compare(dv, model1)

%% ARMA MODEL
data1 = iddata(acc_data(:,4),[],0.068);
arma1 = armax(data1,[4 4]);