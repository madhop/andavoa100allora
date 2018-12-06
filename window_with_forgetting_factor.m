%% MOVING WINDOW
% dataset
dataset = [classe1; classe2; classe3; classe4];

% variances = [var(classe1(:,4)), var(classe2(:,4)), var(classe3(:,4)), var(classe4(:,4))];
% compute accuracy
window_size = 200;
prediction = [];
labels = [];
for i=200:5:size(dataset,1)
    block = dataset(i - window_size + 1 :i,4);
    if var(block) < thr1
        prediction = [prediction, 1];
    elseif var(block) < thr2
        prediction = [prediction, 2];
    elseif var(block) < thr3
        prediction = [prediction, 3];
    else
        prediction = [prediction, 4];
    end
%     [tt,t] = min(abs(variances - var(block)));
%     prediction = [prediction, t];
    if i < size(classe1,1)
        labels = [labels, 1];
    elseif i < size([classe1;classe2],1)
        labels = [labels, 2];
    elseif i < size([classe1;classe2;classe3],1)
        labels = [labels, 3];
    else
        labels = [labels, 4];
    end
end
%%
plot(prediction)
hold on
plot(labels)
hold off

%% ACCURACY
accuracy = sum(((prediction - labels) == 0))/ size(prediction,2)

%% 
auto_var = var(autob(:,4)); %0
bosco_var = var(bosco(:,4)); %1
asph_var = var(asphalt(:,4)); %2
roto_var = var(roto(:,4)); %3
prato_var = var(prato(:,4)); %4
pistra_var = var(piastra(:,4)); %5
sterra_var = var(sterra(:,4)); %6

vars = [auto_var bosco_var asph_var roto_var prato_var pistra_var sterra_var];

window_size = 200;
prediction = [];
for i=1:5:size(asphalt,1)
    if i<window_size
        block = asphalt(1:i,4);
    else
        block = asphalt(i - window_size + 1 :i,4);
    end
    [tt,t] = min(abs(vars - var(block)));
    prediction = [prediction, t];
end