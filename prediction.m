%% LDA
dataset = [classe1(:,4);classe2(:,4);classe3(:,4)];
labels = [ones(size(classe1,1),1); ones(size(classe2,1),1)*2; ones(size(classe3,1),1)*3];

% lda = fitcdiscr(dataset, labels);
% 
% block = classe3(200:400,4);
% p = predict(lda, block);

%% Kullback-Leibler DISTANCE
% block = classe1(200:400,4);
% r = fix(rand(201,1)*size(classe1,1))+1;
% distance1 = KLDiv([1:201]', classe1(r,4)/sum(classe1(r,4)), block/sum(block));
% r = fix(rand(201,1)*size(classe2,1))+1;
% distance2 = KLDiv([1:201]', classe2(r,4)/sum(classe2(r,4)), block/sum(block));
% r = fix(rand(201,1)*size(classe3,1))+1;
% distance3 = KLDiv([1:201]', classe3(r,4)/sum(classe3(r,4)), block/sum(block));
% divergence = [distance1 distance2 distance3]


window_size = 200;
p = [];
l = [];
for i=200:5:size(dataset,1)
    block = dataset(i - window_size + 1 :i);
    r = fix(rand(window_size,1)*size(classe1,1))+1;
    distance1 = KLDiv([1:window_size]', classe1(r,4)/sum(classe1(r,4)), block/sum(block));
    r = fix(rand(window_size,1)*size(classe2,1))+1;
    distance2 = KLDiv([1:window_size]', classe2(r,4)/sum(classe2(r,4)), block/sum(block));
    r = fix(rand(window_size,1)*size(classe3,1))+1;
    distance3 = KLDiv([1:window_size]', classe3(r,4)/sum(classe3(r,4)), block/sum(block));
    divergence = [distance1 distance2 distance3];
    [tt,t] = max(divergence);
    p = [p, t];
    if i < size(classe1,1)
        l = [l, 1];
    elseif i < size([classe1;classe2],1)
        l = [l, 2];
    else
        l = [l, 3];
    end
end

%%
plot(p)
hold on
plot(l)
hold off
%% ACCURACY
accuracy = sum(((p - l) == 0))/ size(p,2)