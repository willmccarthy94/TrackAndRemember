% RunExperiment
% This function should be called whenever th 

function RunExperiment()
rawDataPath = [pwd '/RawData'];
dataPath = [pwd '/Data'];

ExpVars.BlockTypes = [1 2]; % 1: stationary, 2: motion
ExpVars.nTrials = 20; %Trials per block
% ExpVars.colors = []; % NEEDS UPDATING- Save data structure for colour here.

save('ExperimentVars.mat', 'ExpVars');


% Load experimental variables struct
load('ExperimentVars.mat');
    
% Initialize experiment, data structures etc.
data.subinfo.ppt = input('Enter subject number: ');
data.subinfo.age = input('Enter your age: ');
data.subinfo.DateTime = datestr(now);
nTrial = 10;

Screen('Preference', 'SkipSyncTests', 1);
screen_num = 0;
[w, rect] = Screen('OpenWindow', screen_num, 0, [0 0 800 600]);
%Gotta find the center
[xCenter, yCenter] = RectCenter(rect);
%Let's also find the screen size
[screenXpixels, screenYpixels] = Screen('WindowSize', w);
    
%%Instruction text, currently for full screen
Screen('TextFont', w, 'Arial'); Screen('TextSize', w, 20);
Screen('DrawText', w, 'Welcome! Thank you for participating in our study.', 40, 200, [250 250 250]);
Screen('DrawText', w, 'Please read the following instructions carefully:', 40, 240, [250 250 250]);
Screen('DrawText', w,'During each trial, please keep your eyes fixed on the center of the screen.',40, 320, [250 250 250]);
Screen('DrawText', w,'Two circles will be shown, one on the left and one on the right.',40, 360, [250 250 250]);
Screen('DrawText', w,'After being shown the circles, you will be asked to report the color of one of the circles using your keyboard.',40, 400, [250 250 250]);
Screen('DrawText', w,'Let''s practice. Press any key to continue.',40, 480, [250 250 250]);
Screen('Flip',w);
HideCursor;
KbStrokeWait;

%run practice trial and erase data
[PracticeData] = TrialFunctionFunction(nTrial, 0);
clear PracticeData;

%Instructions to start real exp.
Screen('Preference', 'SkipSyncTests', 1);
screen_num = 0;
[w, rect] = Screen('OpenWindow', screen_num, [0 0 0], [0 0 800 600]);
Screen('FillRect', w, [0 0 0], []);
Screen('DrawText', w, 'Great Job! Now let''s start the experiment.', 40, 240, [250 250 250]);
Screen('DrawText', w, 'Press any key to continue.', 40, 280, [250 250 250]);
Screen('Flip',w);
KbStrokeWait;

    
% Counterbalance block types, run trials, and save data
    
if mod(data.subinfo.ppt, 2) == 1
    data.subinfo.moveOrder = 2; % Indicate that move block came second
    [data.still] = TrialFunctionFunction(nTrial, 1);
    save(['/RawData/trackremember_ppt_' num2str(data.subinfo.ppt) '.mat'],'data');
    [data.move] = TrialFunctionFunction(nTrial, 2);
    save(['/RawData/trackremember_ppt_' num2str(data.subinfo.ppt) '.mat'],'data');
else
    data.subinfo.moveOrder = 1; % Indicate that move block came first
    [data.move] = TrialFunctionFunction(nTrial, 2);
    save(['/RawData/trackremember_ppt_' num2str(data.subinfo.ppt) '.mat'],'data');
    [data.still] = TrialFunctionFunction(nTrial, 1);
    save(['/RawData/trackremember_ppt_' num2str(data.subinfo.ppt) '.mat'],'data');
end

Screen('CloseAll');
ShowCursor;


save(fullfile(rawDataPath, filename), 'data');


    
    
end
