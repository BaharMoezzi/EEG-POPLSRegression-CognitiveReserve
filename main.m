clear all; close all; clc;

deltaFreq = 2:4;                                                % freq = 1
thetaFreq = 4:6;                                                % freq = 2
alphaFreq = 7:13;                                               % freq = 3
betaFreq  = 14:30;                                              % freq = 4
gammaFreq = 31:45;                                              % freq = 5
FreqName  = {'delta', 'theta', 'alpha', 'beta', 'gamma'};

N = 2;
M = 3;
freq = 3;                                                       % Enter the index of frequency band of interest 

% Enter your participants' data
Participants = {'ECR_1','ECR_2','ECR_3','ECR_4','ECR_5','ECR_6','ECR_7','ECR_8','ECR_9','ECR_10','ECR_11','ECR_12','ECR_13','ECR_14','ECR_15','ECR_16','ECR_17','ECR_18','ECR_19','ECR_20','ECR_21','ECR_22','ECR_23','ECR_24','ECR_25','ECR_26','ECR_27','ECR_28','ECR_29','ECR_30','ECR_31','ECR_32','ECR_33','ECR_34'};
X1 = zeros(length(Participants),64);
for l = 1 : length(Participants)  
    cd(['D:\' Participants{1,l} '\' FreqName{1,freq}]);        % Enter the path to the functional connectivity data  
    load FCData;                                               % Load yuor functional connectivity data
    A = FCData;
    SeedInex = [3 5 11 12];                                    % Enter your EEG seed electrode numbers
    E = A(SeedInex,:);
    X1(l,1:64) = mean(E,1);
end
% Enter the cognitive reserve scores (LEQ Total)
Y = [145.2,125.225,140.42,121.704,139.75,134.3,64.7,112.102,57.55,65.65,84.6,71.55,111.4,63.5,80.5,118,119.822,75.2,85.15,102.55,91.25,88.5,125.935,89.05,86.8,86.95,111.5,108.3,120.65,93.6,89.15,95.3,116.9,145.6]';

% Enter the cognitive functioning scores (ACE-R)
X2 = [98,95,99,97,97,96,88,71,85,86,87,94,96,89,96,99,96,93,81,90,94,94,94,91,86,88,83,89,92,99,91,92,98,92]';

X1.('d') = (X1-mean(X1))./(std(X1)/sqrt(length(X1)));
X1.('i') = Participants';
X1.('v') = {'1','2','3','4','5','6','7','8','9','10','11','12','13','14','15','16','17','18','19','20','21','22','23','24','25','26','27','28','29','30','31','32','33','34','35','36','37','38','39','40','41','42','43','44','45','46','47','48','49','50','51','52','53','54','55','56','57','58','59','60','61','62','63','64'}';
X2.('d') = (X2-mean(X2))./(std(X2)/sqrt(length(X2)));
X2.('i') = Participants';
X2.('v') = {'ACE-R'};
Y.('d')  = (Y-mean(Y))./(std(Y)/sqrt(length(Y)))';
Y.('i')  = Participants';
Y.('v')  = {'LEQ'}';

X={X1 X2};

cd('D:\posopls');                                              % Enter the path to POSOPLS toolbox

set(groot,'defaultFigureVisible','off')

options = POSO_PLS(X,Y);
options.preprocX{1} = 'autoscale'; 
options.autoselect = 0;
 
[model] = POSO_PLS(X,Y,options);
[model partialYval p] = crossval_POSO_PLS(model,'loo');

R = model.RegCoefs{N};
Connectivity_ExplainedVariance = model.expVarY{N};

Connectivity_p = p(N);

coefficients = polyfit(Y, partialYval(:,1,M), 1);  
connectivity_CrossValidation = coefficients(1).*100;

Index = 1:length(R);
for j = 1 : length(SeedInex)
    Index = Index(Index~=SeedInex(j));
end
NoSeedIndex = Index;
maxRNoSeed = max(abs(R(NoSeedIndex)));

Temp = 0;
R2 = R.^2;
channelList = [];
for k = 1 : length(R)
   if abs(R(k)) > 0.3   
        Temp = Temp + R2(k);
        channelList = [channelList k];
   end
end 

set(groot,'defaultFigureVisible','on')

figure
addpath('D:\eeglab14_1_1b')                                 % Enter path to the EEGLAB toolbox
EEG = pop_loadset('ECR_1Data.set');                         % Enter an EEG sample dataset. This will be used for plotting electrodes on the scalp map.

TempR = zeros(1,64);
topoplot(TempR, EEG.chanlocs, 'emarker2', {SeedInex,'o','k',30,1},'style', 'map');      
topoplot(TempR, EEG.chanlocs, 'emarker2', {channelList,'p','m',30,1},'style', 'map');    
topoplot(R, EEG.chanlocs,'plotchans', [1:64],'style', 'map')
caxis([-1 1])
h = colorbar;
set(h,'fontsize',30);
