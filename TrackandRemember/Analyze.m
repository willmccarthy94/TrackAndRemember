% Analyze data from each subject

%Set Path
dataPath = '';
rawDataPath = '';

cd(dataPath)
addpath(rawDataPath)


files = dir(fullfile(rawDataPath, 'trackremember_ppt_1*.mat')); %List folder contents 
fileIndex = find(~[files.isdir]); % filter out directories
parts = length(fileIndex); % count files


%% Load each subject

for ir = 1:length(fileIndex)
    
    %% Preparation
    
    fileName = files(fileIndex(ir)).name;
    load([rawDataPath '/' fileName]);
    
end