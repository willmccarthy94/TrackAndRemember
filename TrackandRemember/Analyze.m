%% Analyse data
% Basic analysis for experimental data.
% Precondition: Data is parsed using ParseData script.
% IMPORTANT: Make sure you are in TrackandRemember Directory

clc
clear

% Load data
dataPath = [pwd '/Data'];
load(fullfile(dataPath, 'allData'));

% Calculate number of subjects
nsub = length(subjects);

FaceColors = [[0.7,0.7,1]; [1,0.7,0.7]; [0.7,1,0.7]];
TintColors = [[0.6,0.6,1]; [1,0.6,0.6]; [0.6,1,0.6]];


%%  Plot bar of accuracy per subject
% NEED TO SORT LABELS

figure; hold on;

b = bar(mean(accs,3));
b(1).FaceColor = FaceColors(1,:);
b(2).FaceColor = FaceColors(2,:);
b(1).LineStyle = 'none';
b(2).LineStyle = 'none';

xlabel('Subjects');
title('Accuracy per subject per block');
legend({'Still','Motion'});
set(gca, 'xTick', [1:length(subjects)]);
set(gca, 'xTickLabel', subjects);

%%  Plot bar of accuracy averaged over subjects


f = figure; hold on;
b = bar(mean(mean(accs,3)));
b.FaceColor = FaceColors(1,:);
b.LineStyle = 'none';

e = errorbar(mean(mean(accs,3)),(std(mean(accs,3))/sqrt(length((mean(accs,3))))));
e.LineStyle = 'none';
e.LineWidth = 1.5;
e.Color = TintColors(1,:);
set(gca, 'xTick', [1,2]);
set(gca, 'xTickLabel', {'Still','Motion'});
xlabel('Block Type');
ylabel('Accuracy');
title('Average accuracy per block');

%%

colors = subinfo(1).colors;





