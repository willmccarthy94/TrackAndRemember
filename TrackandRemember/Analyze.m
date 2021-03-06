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

e = errorbar(mean(mean(accs,3)),(std(mean(accs,3))/sqrt(length((mean(accs,3)))))); % Mean by subject and standard errors 
e.LineStyle = 'none';
e.LineWidth = 1.5;
e.Color = TintColors(1,:);
set(gca, 'xTick', [1,2]);
set(gca, 'xTickLabel', {'Still','Motion'});
xlabel('Block Type');
ylabel('Accuracy');
title('Average accuracy per block');

%%

%temporary colors
%% Colors
%This are the 8 colors
Color1 = [225 0 57];
Color2 = [221 0 123];
Color3 = [217 0 186];
Color4 = [160 32 240];
Color5 = [180 0 213];
Color6 = [114 0 210];
Color7 = [70 0 206];
Color8 = [50 0 220];

%I'll make the color array and assign the approporiate colors. To help
%visualize it, I recommend evaluating this part and looking at the
%array.

ColorArray = zeros(8,4);
ColorArray(:,1) = [1:8]';

ColorArray(1,2:end) = Color1;
ColorArray(2,2:end) = Color2;
ColorArray(3,2:end) = Color3;
ColorArray(4,2:end) = Color4;
ColorArray(5,2:end) = Color5;
ColorArray(6,2:end) = Color6;
ColorArray(7,2:end) = Color7;
ColorArray(8,2:end) = Color8;


%%

%Fetch colors
%colors = subinfo(1).colors;
colors = ColorArray;

% Grab one color
%ColorArray(1,2:4)







