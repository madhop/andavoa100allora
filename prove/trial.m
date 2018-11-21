clear
clc
close all

load iddata_TimeSeriesPrediction
n = numel(y);
ns = floor(n/2);
y_id = y(1:ns,:);
y_v = y((ns+1:end),:);
data_id = iddata(y_id, [], Ts, 'TimeUnit', 'hours');
data_v  = iddata(y_v, [], Ts, 'TimeUnit', 'hours', 'Tstart', ns+1);

plot(data_id,data_v)
legend('Identification data','Validation data','location','SouthEast');

%%
sys = ssest(data_id,1,'Ts',Ts,'form','canonical');
nstep = 10;
compare(sys,data_id,nstep)  % comparison of 10-step prediction to estimation data
grid('on');