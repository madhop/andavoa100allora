% BLOCK VARIANCE
step = 200;
%% AUTOBLOCCANTI
autob_v = [];
autob_p = [];
for i = 1:fix(size(autob,1)/step)
    block = autob((i-1)*step + 1:i*step,4);
    autob_v = [autob_v; var(block)];
    autob_p = [autob_p; prctile(block, 75)];
end
%% BOSCO
bosco_v = [];
bosco_p = [];
for i = 1:fix(size(bosco,1)/step)
    block = bosco((i-1)*step + 1:i*step,4);
    bosco_v = [bosco_v; var(block)];
    bosco_p = [bosco_p; prctile(block, 75)];
end
% plot(bosco_v)
%% ASFALTO
asph_v = [];
asph_p = [];
for i = 1:fix(size(asphalt,1)/step)
    block = asphalt((i-1)*step + 1:i*step,4);
    asph_v = [asph_v; var(block)];
    asph_p = [asph_p; prctile(block, 75)];
end
%% ROTO
roto_v = [];
roto_p = [];
for i = 1:fix(size(roto,1)/step)
    block = roto((i-1)*step + 1:i*step,4);
    roto_v = [roto_v; var(block)];
    roto_p = [roto_p; prctile(block, 75)];
end
%% PRATO
prato_v = [];
prato_p = [];
for i = 1:fix(size(prato,1)/step)
    block = prato((i-1)*step + 1:i*step,4);
    prato_v = [prato_v; var(block)];
    prato_p = [prato_p; prctile(block, 75)];
end

%% PIASTRELLE
piastra_v = [];
piastra_p = [];
for i = 1:fix(size(piastra,1)/step)
    block = piastra((i-1)*step + 1:i*step,4);
    piastra_v = [piastra_v; var(block)];
    piastra_p = [piastra_p; prctile(block, 75)];
end

%% STERRATO
sterra_v = [];
sterra_p = [];
for i = 1:fix(size(sterra,1)/step)
    block = sterra((i-1)*step + 1:i*step,4);
    sterra_v = [sterra_v; var(block)];
    sterra_p = [sterra_p; prctile(block, 75)];
end

%% MERGE VARIANCES

variances = [autob_v;
    bosco_v;
    asph_v;
    roto_v;
    prato_v;
    piastra_v;
    sterra_v];

labels = [];    
lab = ['AUTOB  '];
labels = [labels; repmat(lab,size(autob_v,1),1)];
lab = ['BOSCO  '];
labels = [labels; repmat(lab,size(bosco_v,1),1)];
lab = ['ASPH   '];
labels = [labels; repmat(lab,size(asph_v,1),1)];
lab = ['ROTO   '];
labels = [labels; repmat(lab,size(roto_v,1),1)];
lab = ['PRATO  '];
labels = [labels; repmat(lab,size(prato_v,1),1)];
lab = ['PIASTRA'];
labels = [labels; repmat(lab,size(piastra_v,1),1)];
lab = ['STERRA '];
labels = [labels; repmat(lab,size(sterra_v,1),1)];


%% PLOT PERCENTILE SUP 1D 
plot(autob_p, 0, 'b.')
hold on
% plot(var(autob(:,4)), 0, 'r*')
plot(bosco_p, 1, 'b.')
% plot(var(bosco(:,4)), 1, 'r*')
plot(asph_p, 2, 'b.')
plot(roto_p, 3, 'b.')
plot(prato_p, 4, 'b.')
plot(piastra_p, 5, 'b.')
plot(sterra_p, 6, 'b.')

%% PLOT VAR 1D 
plot(autob_v, 0, 'b.')
hold on
plot(var(autob(:,4)), 0, 'r*')
plot(bosco_v, 1, 'b.')
plot(var(bosco(:,4)), 1, 'r*')
plot(asph_v, 2, 'b.')
plot(var(asphalt(:,4)), 2, 'r*')
plot(roto_v, 3, 'b.')
plot(var(roto(:,4)), 3, 'r*')
plot(prato_v, 4, 'b.')
plot(var(prato(:,4)), 4, 'r*')
plot(piastra_v, 5, 'b.')
plot(var(piastra(:,4)), 5, 'r*')
plot(sterra_v, 6, 'b.')
plot(var(sterra(:,4)), 6, 'r*')
hold off

%% PLOT VAR 1D 
% dataset = [asphalt(:,4);
%            ciotto(:,4);
%            autob(:,4);
%            bosco(:,4);
%            roto(:,4);
%            prato(:,4);
%            piastra(:,4); 
%            sterra(:,4)];


plot(var(asphalt(:,4)), 0, 'r*')
hold on
plot(var(autob(:,4)), 1, 'r*')
plot(var(prato(:,4)), 2, 'r*')
plot(var(piastra(:,4)), 3, 'r*')
plot(var(sterra(:,4)), 4, 'r*')
plot(var(roto(:,4)), 5, 'r*')
plot(var(ciotto(:,4)), 6, 'r*')
plot(var(bosco(:,4)), 7, 'r*')
hold off

%% block variace CLASSi
step = 200;
c1_var = [];
for i = 1:fix(size(classe1,1)/step)
    block = classe1((i-1)*step + 1:i*step,4);
    c1_var = [c1_var; var(block)];
end

c2_var = [];
for i = 1:fix(size(classe2,1)/step)
    block = classe2((i-1)*step + 1:i*step,4);
    c2_var = [c2_var; var(block)];
end
c3_var = [];
for i = 1:fix(size(classe3,1)/step)
    block = classe3((i-1)*step + 1:i*step,4);
    c3_var = [c3_var; var(block)];
end
% c4_var = [];
% for i = 1:fix(size(classe4,1)/step)
%     block = classe4((i-1)*step + 1:i*step,4);
%     c4_var = [c4_var; var(block)];
% end

%% PLOT VAR 4 CLASSES
plot(var(classe1(:,4)), 0, 'r*')
hold on
plot(c1_var, 0, 'b.')
plot(var(classe2(:,4)), 1, 'r*')
plot(c2_var, 1, 'b.')
plot(var(classe3(:,4)), 2, 'r*')
plot(c3_var, 2, 'b.')
% plot(var(classe4(:,4)), 3, 'r*')
% plot(c4_var, 3, 'b.')
hold off

%% normalized squared
plot((classe1(:,4)-mean(classe1(:,4))).^2, 0, 'r*')
hold on
plot(c1_var, 0, 'b.')
plot((classe2(:,4)-mean(classe2(:,4))).^2, 1, 'r*')
plot(c2_var, 1, 'b.')
plot((classe3(:,4)-mean(classe3(:,4))).^2, 2, 'r*')
plot(c3_var, 2, 'b.')
% plot(var(classe4(:,4)), 3, 'r*')
% plot(c4_var, 3, 'b.')
hold off

%% VARIANCES
variances = [var(classe1(:,4)), var(classe2(:,4)), var(classe3(:,4)), var(classe4(:,4))];

thr1 = (0.4*var(classe1(:,4)) + 0.6*var(classe2(:,4)))/2;
thr2 = (1*var(classe2(:,4)) + 1*var(classe3(:,4)))/2;
thr3 = (0.4*var(classe3(:,4)) + 0.6*var(classe4(:,4)))/2;