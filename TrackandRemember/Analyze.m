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

%%  Plot bar of accuracy per subject
% NEED TO SORT LABELS

figure; hold on;
bar(mean(accs,3));
xticklabels(subjects);
xlabel('subjects');

%%  Plot bar of accuracy averaged over subjects
% NOT SURE IF CORRE

figure; hold on;
bar(mean(mean(accs,3)));
e = errorbar(mean(mean(accs,3)),std(mean(accs,3)));
e.LineStyle = 'none';
e.LineWidth = 2;
xticklabels(subjects);
xlabel('subjects');
