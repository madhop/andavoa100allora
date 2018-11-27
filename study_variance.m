% PERVASIVE
close all
clear
clc


% tempo, x, y, z
% tempo, latitudine, longitudine
%% read data
data = readtable('long221118.csv'); %f211118
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

d1 = asphalt(1:250);
d2 = asphalt(251:530);
d3 = asphalt(531:880);

% split_asphalt{4} = asphalt(301:400);
% split_asphalt{5} = asphalt(401:500);
% split_asphalt{6} = asphalt(501:600);
% split_asphalt{7} = asphalt(601:700);
% split_asphalt{8} = asphalt(701:800);

% merge
% d = merge(split_asphalt{1},split_asphalt{2},split_asphalt{3}, split_asphalt{4},split_asphalt{5}, split_asphalt{6}, split_asphalt{7}, split_asphalt{8});
d = merge(d1,d2,d3)

d.exp = {'Period 1';'Day 2';'Phase 3'}
de = getexp(d,[1,2]);      % subselection is done using  the command GETEXP 
dv = getexp(d,'Phase 3');  % using numbers or names.

%% MODEL 
model1 = armax(de,[4 4]);
compare(dv, model1)

%% ARMA MODEL
% data1 = iddata(acc_data(:,4),[],0.068);
arma1 = armax(asphalt,[5 5]);
compare(asphalt, arma1)

%% SEPARIAMOLI TUTTI
autob = acc_data(find(acc_data(:,1)>= 14767159 & acc_data(:,1)<= 14868275), :);
bosco1 = acc_data(find(acc_data(:,1)>= 14934292 & acc_data(:,1)<= 15115430), :);
asphalt = acc_data(find(acc_data(:,1)>= 15210511 & acc_data(:,1)<= 15262562), :);
roto1 = acc_data(find(acc_data(:,1)>= 15380649 & acc_data(:,1)<= 15431687), :);
prato = acc_data(find(acc_data(:,1)>= 15453539 & acc_data(:,1)<= 15501570), :);
piastra1 = acc_data(find(acc_data(:,1)>= 15559780 & acc_data(:,1)<= 15583643), :);
sterra = acc_data(find(acc_data(:,1)>= 15608653 & acc_data(:,1)<= 15624877), :);
piastra2 = acc_data(find(acc_data(:,1)>= 15633668 & acc_data(:,1)<= 15679876), :);
roto2 = acc_data(find(acc_data(:,1)>= 15731754 & acc_data(:,1)<= 15786963), :);
bosco2 = acc_data(find(acc_data(:,1)>= 16012153), :);

%%

hist(bosco2(:,4),100);
