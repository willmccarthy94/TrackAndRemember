nTrial = 20; %For now

%% Response Screen

% Just for now
Screen('Preference', 'SkipSyncTests', 1 );
screen_num = 0;
[w, rect] = Screen('OpenWindow', screen_num, [0 0 0]);
%Gotta find the center
[xCenter, yCenter] = RectCenter(rect);
%Let's also find the screen size
[screenXpixels, screenYpixels] = Screen('WindowSize', w);

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

%% Set up dot variables + Fixation cross

%Draw a fixation point on the center
xCoords = [-40 40 0 0];
yCoords = [0 0 -40 40];
allCoords = [xCoords; yCoords];

%Dot size/location info
dot.size = 100;
dot.LocationL = [xCenter-500, yCenter]; %Left
dot.LocationR = [xCenter+500, yCenter]; %Right
black = [0 0 0];
white = [255 255 255];
%% Set up trial arrays
%Here I'm creating trial indexes. Again, I recommend evaluating just this
%section to help visualizing what I'm trying to do.
TrialArray1 = [1:8]; %Because there are 8 colors total

if nTrial<=length(TrialArray1)
    TrialArray1 = TrialArray1(1:nTrial);
elseif nTrial>length(TrialArray1)
    TrialArray1 = repmat(TrialArray1, [1, nTrial]);
    TrialArray1 = TrialArray1(1:nTrial);
end
%This if statement will make sure there are nTrial number of elements in
%the TrialArray

TrialArray2 = [1:8];

if nTrial<=length(TrialArray2)
    TrialArray2 = TrialArray2(1:nTrial);
elseif nTrial>length(TrialArray2)
    TrialArray2 = repmat(TrialArray2, [1, nTrial]);
    TrialArray2 = TrialArray2(1:nTrial);
end
%There must be 2 Trial Arrays since we have 2 dots.
TrialArray1 = Shuffle(TrialArray1);
TrialArray2 = Shuffle(TrialArray2);
TrialArray = [TrialArray1;TrialArray2];

%Set it
TrialMotion = TrialArray;
TrialStat = TrialArray;

%% Target Array (Left of Right)
%This is another array deciding whether the target will be left or right.
TargetArray = [1 2];
TargetArray = repmat(TargetArray, [1 nTrial]);
TargetArray = TargetArray(1:nTrial);
TargetArray = Shuffle(TargetArray);
%% Find the locations/size for the options
%Here I'll set the locations of options for the response screen. I tried to
%soft code this but if it doesn't work on your screen I recommend tweaking
%it around.
InitialX = screenXpixels/4;
Gap = 0;
squareSize = 50;

for i = 1:8
    ColorLocation(i,:) = [xCenter-InitialX+Gap-squareSize, yCenter-squareSize, xCenter-InitialX+Gap+squareSize, yCenter+squareSize];
    Gap = Gap+150;
end

%% Trial+Reponse Screen
keypress = 0;

for j = 1:nTrial
    Screen('DrawText', w, ['Press any key to start'], xCenter-150, yCenter, white);
    Screen('Flip', w);
    KbStrokeWait; %Wait until a key press
    
    %Set target location
    if TargetArray(j) == 1 %Left
        TargetLocation = dot.LocationL;
    elseif TargetArray(j) == 2 %Right
        TargetLocation = dot.LocationR;
    end
    
    %Color information for each dot
    colorInfo1 = ColorArray(TrialStat(1,j), 2:end);
    colorInfo2 = ColorArray(TrialStat(2,j), 2:end);
    
    HideCursor();
    
    Screen('DrawLines', w, allCoords, 4, white, [xCenter yCenter]); %Fixation Cross
    Screen('Flip', w);
    WaitSecs(1);
    
    %Draw two dots
    Screen('DrawDots', w, dot.LocationL, dot.size, colorInfo1, [0 0], [1]); %This is random color dot
    Screen('DrawDots', w, dot.LocationR, dot.size, colorInfo2, [0 0], [1]); %Another random color dot
    Screen('DrawLines', w, allCoords, 4, white, [xCenter yCenter]); %Fixation Cross
    Screen('Flip', w);
    WaitSecs(2);
    
    %Reponse Screen
    while(~KbCheck)
        Screen('FillRect', w, Color1, ColorLocation(1,:));
        Screen('FillRect', w, Color2, ColorLocation(2,:));
        Screen('FillRect', w, Color3, ColorLocation(3,:));
        Screen('FillRect', w, Color4, ColorLocation(4,:));
        Screen('FillRect', w, Color5, ColorLocation(5,:));
        Screen('FillRect', w, Color6, ColorLocation(6,:));
        Screen('FillRect', w, Color7, ColorLocation(7,:));
        Screen('FillRect', w, Color8, ColorLocation(8,:));
        
        if TargetArray(j) == 1
            Screen('DrawText', w, '<---', xCenter-100, yCenter-300);
        elseif TargetArray(j) == 2
            Screen('DrawText', w, '--->', xCenter-100, yCenter-300);
        end
        Screen('Flip', w);
        keypress = KbCheck;
    end
end

sca