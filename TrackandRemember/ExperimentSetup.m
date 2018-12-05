% This file provides details about the basic setup of the experiment
% It include code snippets to be copied into actual files and functions

%% Experiment Variables
% These will be initialised before ever running the experiment 
% They should be saved in a struct ExpVars saved in ExperimentVars.mat
% These variables can then be loaded at the start of any script

ExpVars.BlockTypes = [1 2]; % 1: stationary, 2: motion
ExpVars.nTrials = 20; %Trials per block
% ExpVars.colors = []; % NEEDS UPDATING- Save data structure for colour here.

save('ExperimentVars.mat', 'ExpVars');

%% Saved Files
% This section gives naming conventions for saved files

% Experimental Variables should be saved in the following file
save('ExperimentVars.mat', 'ExpVars');

%Data
% Each subject's data should be stored in a file with the following naming convention:
save('/RawData/trackremember_ppt_XXX.mat','data');
%These can then be 'looped over' for analysis

%% Setup for analysis
% IMPORTANT: Make sure you are working from TrackandRemember folder in
% order to access correct files

clc
clear

rawDataPath = [pwd '/RawData'];
dataPath = [pwd '/Data'];

%save(fullfile(dataPath, 'allData'), 'allData');
%save(fullfile(rawDataPath, 'trackremember_ppt_XXX.mat'), 'data');


%load(fullfile(rawDataPath, 'trackremember_ppt_XXX.mat'));


%% Example participant data structure
% Save this for each participant. Analysis script will compile these into
% one file


data.ppt = 102;
data.age = 28;
data.DateTime = datetime;

data.move.resp = [8 2 3 5 3 1 4 5 2 7] % Value from 1..8 representing color selection
data.move.expr = [8 2 1 1 3 3 4 5 6 7] % Value from 1..8 representing correct color
data.move.acc = data.move.resp == data.move.expr % 1 for correct response, 0 for incorrect

data.still.resp = [4 2 4 1 7 1 4 5 2 7] % Value from 1..8 representing color selection
data.still.expr =  [4 2 3 1 7 3 4 5 6 7] % Value from 1..8 representing correct color
data.still.acc = data.move.resp == data.move.expr % 1 for correct response, 0 for incorrect

