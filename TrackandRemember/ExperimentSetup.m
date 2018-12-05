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

rawDataPath = [pwd '/RawData'];
dataPath = [pwd '/Data'];

save(fullfile(dataPath, 'allData'), 'allData');
save(fullfile(rawDataPath, 'trackremember_ppt_XXX.mat'), 'data');


%% Participant data structure
% Save this for each participant. Analysis script will compile these into
% one file

data.move.resp = % Value from 1..8 representing color selection
data.move.ans = % Value from 1..8 representing correct color
data.move.acc = % 1 for correct response, 0 for incorrect

data.still.resp = % Value from 1..8 representing color selection
data.still.ans = % Value from 1..8 representing correct color
data.still.acc = % 1 for correct response, 0 for incorrect


