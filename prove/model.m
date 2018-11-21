clear
clc
close all

data1_csv = csvread("data/1.csv");
data2_csv = csvread("data/2.csv");
data3_csv = csvread("data/3.csv");

%%
data1 = iddata(data1_csv(:,4),[],0.03);
data2 = iddata(data2_csv(:,4),[],0.03);
data3 = iddata(data3_csv(:,4),[],0.03);


%% ARMA
arma1 = armax(data1,[4 4]);
arma2 = armax(data2,[4 4]);

figure
compare(arma1,data1,10)
grid('on');

figure
compare(arma2,data2,10)
grid('on');
%% STATE SPACE
ss1 = ssest(data1,2,'Ts',0.03,'form','canonical');
ss2 = ssest(data2,2,'Ts',0.03,'form','canonical');

figure
compare(ss1,data1,10)  
grid('on');

figure
compare(ss2,data2,10)  % comparison of 10-step prediction to estimation data
grid('on');

%%

[y_1,fit_1,x0_1] = compare(arma2,data3,1)