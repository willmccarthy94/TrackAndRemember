%0: practice, 1: still, 2: motion

function [blockdata] = TrialFunctionFunction(nTrial,TrialType)


    %% Response Screen
    % Just for now
    Screen('Preference', 'SkipSyncTests', 0);
    res=[0 0 800 600]; % setting size of window to be displayed
    %res=[];
    screen_num = 0;
    [w, rect] = Screen('OpenWindow', screen_num, 0, res);

    %Gotta find the center
    [xCenter, yCenter] = RectCenter(rect);
    %Let's also find the screen size
    [screenXpixels, screenYpixels] = Screen('WindowSize', w);
    vbl = Screen('Flip', w);

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
    dot.size = 40;
    dot.velocity=10; 
    dot.LocationL = [screenXpixels/4, yCenter]; %Left
    dot.LocationR = [screenXpixels*3/4, yCenter]; %Right
    black = [0 0 0];
    white = [255 255 255];

    stimDur=2;
    ISI=1;
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

    squareSize = screenXpixels/16;
    [xCenter, yCenter] = RectCenter(rect);

    for i = 1:8
        ColorLocation(i,:) = [(screenXpixels*i/18)+(squareSize*(i-1)) , yCenter-squareSize/2, (screenXpixels*i/18 )+( squareSize*i), yCenter+squareSize/2 ];
        LetterLoc(i,:) = [(screenXpixels*i/18)+(squareSize*(i-1)) , yCenter+squareSize/2];
    end
    %% Trial+Reponse Screen










%PRACTICE_____________________________________________________________________________________________________________________________________________
if TrialType == 0
    keypress = 0;
    
    whichKeys = [KbName('a') KbName('s') KbName('d') KbName('f') KbName('j') KbName('k') KbName('l') KbName(';')];
    nTrial = 3;
    
        Screen('DrawText', w, ['Press any key to start'], screenXpixels/5, yCenter, white);
        Screen('Flip', w);
        KbStrokeWait; %Wait until a key press
        
    for j = 1:nTrial
        
        WaitSecs(ISI);
        
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
        WaitSecs(ISI);
        
        %Draw two dots       
        Screen('FillOval', w , colorInfo1, [dot.LocationL(1)-dot.size dot.LocationL(2)-dot.size dot.LocationL(1)+dot.size dot.LocationL(2)+dot.size],2*dot.size);
        %Start ball 1 at the center of left field        
        Screen('FillOval', w , colorInfo2, [dot.LocationR(1)-dot.size dot.LocationR(2)-dot.size dot.LocationR(1)+dot.size dot.LocationR(2)+dot.size],2*dot.size);
        %Start ball 1 at the center of right field
        Screen('DrawLines', w, allCoords, 4, white, [xCenter yCenter]); %Fixation Cross
        Screen('Flip', w);
        WaitSecs(stimDur);
        
        [keyIsDown,secs,keyCode]=KbCheck();
        
        %Reponse Screen
        while(~any(keyCode(whichKeys)))
            Screen('FillRect', w, Color1, ColorLocation(1,:));
            Screen('FillRect', w, Color2, ColorLocation(2,:));
            Screen('FillRect', w, Color3, ColorLocation(3,:));
            Screen('FillRect', w, Color4, ColorLocation(4,:));
            Screen('FillRect', w, Color5, ColorLocation(5,:));
            Screen('FillRect', w, Color6, ColorLocation(6,:));
            Screen('FillRect', w, Color7, ColorLocation(7,:));
            Screen('FillRect', w, Color8, ColorLocation(8,:));
            
            Screen('TextFont', w, 'Times'); %set text font
            Screen('TextSize', w,20 ); %set text size
            Screen('DrawText', w, 'a', LetterLoc(1,1),LetterLoc(1,2), [250 250 250]);
            Screen('DrawText', w, 's', LetterLoc(2,1),LetterLoc(2,2), [250 250 250]);
            Screen('DrawText', w, 'd', LetterLoc(3,1),LetterLoc(3,2), [250 250 250]);
            Screen('DrawText', w, 'f', LetterLoc(4,1),LetterLoc(4,2), [250 250 250]);
            Screen('DrawText', w, 'j', LetterLoc(5,1),LetterLoc(5,2), [250 250 250]);
            Screen('DrawText', w, 'k', LetterLoc(6,1),LetterLoc(6,2), [250 250 250]);
            Screen('DrawText', w, 'l', LetterLoc(7,1),LetterLoc(7,2), [250 250 250]);
            Screen('DrawText', w, ';', LetterLoc(8,1),LetterLoc(8,2),  [250 250 250]);
            %set location of answer keys below corresponding color answer
            %box
            
            Screen('DrawLine',w, white, screenXpixels/2-screenXpixels/20, screenYpixels/4, screenXpixels/2+screenXpixels/20 ,screenYpixels/4, 6);
            % horizontal line for prompt arrow
            
            if TargetArray(j) == 1
                Screen('DrawLine',w, white, screenXpixels/2-screenXpixels/20, screenYpixels/4, screenXpixels/2 ,screenYpixels/4+screenYpixels/20, 6);
                Screen('DrawLine',w, white, screenXpixels/2-screenXpixels/20, screenYpixels/4, screenXpixels/2 ,screenYpixels/4-screenYpixels/20, 6);
                % left arrowhead for prompt arrow
                blockdata.expr(j) = ColorArray(TrialStat(1,j), 1);
            elseif TargetArray(j) == 2
                Screen('DrawLine',w, white, screenXpixels/2+screenXpixels/20, screenYpixels/4, screenXpixels/2 ,screenYpixels/4+screenYpixels/20, 6);
                Screen('DrawLine',w, white, screenXpixels/2+screenXpixels/20, screenYpixels/4, screenXpixels/2 ,screenYpixels/4-screenYpixels/20, 6);
                % right arrowhead for prompt arrow
                blockdata.expr(j) = ColorArray(TrialStat(2,j), 1);
            end
            Screen('Flip', w);
            KbStrokeWait; %Wait until a key press

%STILL TRIAL_____________________________________________________________________________________________________________
elseif TrialType == 1
    keypress = 0;
    
    whichKeys = [KbName('a') KbName('s') KbName('d') KbName('f') KbName('j') KbName('k') KbName('l') KbName(';')];
    
    Screen('DrawText', w, ['Press any key to start'], screenXpixels/5, yCenter, white);
    Screen('Flip', w);
    KbStrokeWait; %Wait until a key pres
    
    for j = 1:nTrial                     
        
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
        WaitSecs(ISI);
        
        %Draw two dots       
        Screen('FillOval', w , colorInfo1, [dot.LocationL(1)-dot.size dot.LocationL(2)-dot.size dot.LocationL(1)+dot.size dot.LocationL(2)+dot.size],2*dot.size);
        %Start ball 1 at the center of left field        
        Screen('FillOval', w , colorInfo2, [dot.LocationR(1)-dot.size dot.LocationR(2)-dot.size dot.LocationR(1)+dot.size dot.LocationR(2)+dot.size],2*dot.size);
        %Start ball 1 at the center of right field
        Screen('DrawLines', w, allCoords, 4, white, [xCenter yCenter]); %Fixation Cross
        Screen('Flip', w);
        WaitSecs(stimDur);
        
        [keyIsDown,secs,keyCode]=KbCheck();
        
        %Reponse Screen
        while(~any(keyCode(whichKeys)))
            Screen('FillRect', w, Color1, ColorLocation(1,:));
            Screen('FillRect', w, Color2, ColorLocation(2,:));
            Screen('FillRect', w, Color3, ColorLocation(3,:));
            Screen('FillRect', w, Color4, ColorLocation(4,:));
            Screen('FillRect', w, Color5, ColorLocation(5,:));
            Screen('FillRect', w, Color6, ColorLocation(6,:));
            Screen('FillRect', w, Color7, ColorLocation(7,:));
            Screen('FillRect', w, Color8, ColorLocation(8,:));
            
            Screen('TextFont', w, 'Times'); %set text font
            Screen('TextSize', w,20 ); %set text size
            Screen('DrawText', w, 'a', LetterLoc(1,1),LetterLoc(1,2), [250 250 250]);
            Screen('DrawText', w, 's', LetterLoc(2,1),LetterLoc(2,2), [250 250 250]);
            Screen('DrawText', w, 'd', LetterLoc(3,1),LetterLoc(3,2), [250 250 250]);
            Screen('DrawText', w, 'f', LetterLoc(4,1),LetterLoc(4,2), [250 250 250]);
            Screen('DrawText', w, 'j', LetterLoc(5,1),LetterLoc(5,2), [250 250 250]);
            Screen('DrawText', w, 'k', LetterLoc(6,1),LetterLoc(6,2), [250 250 250]);
            Screen('DrawText', w, 'l', LetterLoc(7,1),LetterLoc(7,2), [250 250 250]);
            Screen('DrawText', w, ';', LetterLoc(8,1),LetterLoc(8,2),  [250 250 250]);
            
            Screen('DrawLine',w, white, screenXpixels/2-screenXpixels/20, screenYpixels/4, screenXpixels/2+screenXpixels/20 ,screenYpixels/4, 6);
            % horizontal line for prompt arrow
            
            if TargetArray(j) == 1
                Screen('DrawLine',w, white, screenXpixels/2-screenXpixels/20, screenYpixels/4, screenXpixels/2 ,screenYpixels/4+screenYpixels/20, 6);
                Screen('DrawLine',w, white, screenXpixels/2-screenXpixels/20, screenYpixels/4, screenXpixels/2 ,screenYpixels/4-screenYpixels/20, 6);
                % left arrowhead for prompt arrow
                blockdata.expr(j) = ColorArray(TrialStat(1,j), 1);
            elseif TargetArray(j) == 2
                Screen('DrawLine',w, white, screenXpixels/2+screenXpixels/20, screenYpixels/4, screenXpixels/2 ,screenYpixels/4+screenYpixels/20, 6);
                Screen('DrawLine',w, white, screenXpixels/2+screenXpixels/20, screenYpixels/4, screenXpixels/2 ,screenYpixels/4-screenYpixels/20, 6);
                % right arrowhead for prompt arrow
                blockdata.expr(j) = ColorArray(TrialStat(2,j), 1);
            end

            %Color information for each dot
            colorInfo1 = ColorArray(TrialStat(1,j), 2:end);
            colorInfo2 = ColorArray(TrialStat(2,j), 2:end);

            HideCursor();

            Screen('DrawLines', w, allCoords, 4, white, [xCenter yCenter]); %Fixation Cross
            Screen('Flip', w);
            WaitSecs(ISI);

            %Draw two dots       
            Screen('FillOval', w , colorInfo1, [dot.LocationL(1)-dot.size dot.LocationL(2)-dot.size dot.LocationL(1)+dot.size dot.LocationL(2)+dot.size],2*dot.size);
            %Start ball 1 at the center of left field        
            Screen('FillOval', w , colorInfo2, [dot.LocationR(1)-dot.size dot.LocationR(2)-dot.size dot.LocationR(1)+dot.size dot.LocationR(2)+dot.size],2*dot.size);
            %Start ball 1 at the center of right field
            Screen('DrawLines', w, allCoords, 4, white, [xCenter yCenter]); %Fixation Cross
            Screen('Flip', w);
            WaitSecs(stimDur);

            [keyIsDown,secs,keyCode]=KbCheck();

            %Reponse Screen
            while(~any(keyCode(whichKeys)))
                Screen('FillRect', w, Color1, ColorLocation(1,:));
                Screen('FillRect', w, Color2, ColorLocation(2,:));
                Screen('FillRect', w, Color3, ColorLocation(3,:));
                Screen('FillRect', w, Color4, ColorLocation(4,:));
                Screen('FillRect', w, Color5, ColorLocation(5,:));
                Screen('FillRect', w, Color6, ColorLocation(6,:));
                Screen('FillRect', w, Color7, ColorLocation(7,:));
                Screen('FillRect', w, Color8, ColorLocation(8,:));

                Screen('TextFont', w, 'Times'); %set text font
                Screen('TextSize', w,20 ); %set text size
                Screen('DrawText', w, 'a', LetterLoc(1,1),LetterLoc(1,2), [250 250 250]);
                Screen('DrawText', w, 's', LetterLoc(2,1),LetterLoc(2,2), [250 250 250]);
                Screen('DrawText', w, 'd', LetterLoc(3,1),LetterLoc(3,2), [250 250 250]);
                Screen('DrawText', w, 'f', LetterLoc(4,1),LetterLoc(4,2), [250 250 250]);
                Screen('DrawText', w, 'j', LetterLoc(5,1),LetterLoc(5,2), [250 250 250]);
                Screen('DrawText', w, 'k', LetterLoc(6,1),LetterLoc(6,2), [250 250 250]);
                Screen('DrawText', w, 'l', LetterLoc(7,1),LetterLoc(7,2), [250 250 250]);
                Screen('DrawText', w, ';', LetterLoc(8,1),LetterLoc(8,2),  [250 250 250]);
                %set location of answer keys below corresponding color answer
                %box

                Screen('DrawLine',w, white, screenXpixels/2-screenXpixels/20, screenYpixels/4, screenXpixels/2+screenXpixels/20 ,screenYpixels/4, 7);
                % horizontal line for prompt arrow

                if TargetArray(j) == 1
                    Screen('DrawLine',w, white, screenXpixels/2-screenXpixels/20, screenYpixels/4, screenXpixels/2 ,screenYpixels/4+screenYpixels/20, 7);
                    Screen('DrawLine',w, white, screenXpixels/2-screenXpixels/20, screenYpixels/4, screenXpixels/2 ,screenYpixels/4-screenYpixels/20, 7);
                    % left arrowhead for prompt arrow
                    blockdata.expr(j) = ColorArray(TrialStat(1,j), 1);
                elseif TargetArray(j) == 2
                    Screen('DrawLine',w, white, screenXpixels/2+screenXpixels/20, screenYpixels/4, screenXpixels/2 ,screenYpixels/4+screenYpixels/20, 7);
                    Screen('DrawLine',w, white, screenXpixels/2+screenXpixels/20, screenYpixels/4, screenXpixels/2 ,screenYpixels/4-screenYpixels/20, 7);
                    % right arrowhead for prompt arrow
                    blockdata.expr(j) = ColorArray(TrialStat(2,j), 1);
                end
                Screen('Flip', w);
                [keyIsDown,secs,keyCode]=KbCheck();
            end


            if (keyCode(KbName('a')))
                blockdata.resp(j) = 1;
            elseif (keyCode(KbName('s')))
                blockdata.resp(j) = 2;
            elseif (keyCode(KbName('d')))
                blockdata.resp(j) = 3;
            elseif (keyCode(KbName('f')))
                blockdata.resp(j) = 4;
            elseif (keyCode(KbName('j')))
                blockdata.resp(j) = 5;
            elseif (keyCode(KbName('k')))
                blockdata.resp(j) = 6;
            elseif (keyCode(KbName('l')))
                blockdata.resp(j) = 7;
            elseif (keyCode(KbName(';')))
                blockdata.resp(j) = 8;
            end


        end

    %STILL TRIAL_____________________________________________________________________________________________________________
    elseif TrialType == 1
        keypress = 0;

        whichKeys = [KbName('a') KbName('s') KbName('d') KbName('f') KbName('j') KbName('k') KbName('l') KbName(';')];

        Screen('DrawText', w, ['Press any key to start'], screenXpixels/5, yCenter, white);
        Screen('Flip', w);
        KbStrokeWait; %Wait until a key pres

        for j = 1:nTrial                     

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
            WaitSecs(ISI);

            %Draw two dots       
            Screen('FillOval', w , colorInfo1, [dot.LocationL(1)-dot.size dot.LocationL(2)-dot.size dot.LocationL(1)+dot.size dot.LocationL(2)+dot.size],2*dot.size);
            %Start ball 1 at the center of left field        
            Screen('FillOval', w , colorInfo2, [dot.LocationR(1)-dot.size dot.LocationR(2)-dot.size dot.LocationR(1)+dot.size dot.LocationR(2)+dot.size],2*dot.size);
            %Start ball 1 at the center of right field
            Screen('DrawLines', w, allCoords, 4, white, [xCenter yCenter]); %Fixation Cross
            Screen('Flip', w);
            WaitSecs(stimDur);

            [keyIsDown,secs,keyCode]=KbCheck();

            %Reponse Screen
            while(~any(keyCode(whichKeys)))
                Screen('FillRect', w, Color1, ColorLocation(1,:));
                Screen('FillRect', w, Color2, ColorLocation(2,:));
                Screen('FillRect', w, Color3, ColorLocation(3,:));
                Screen('FillRect', w, Color4, ColorLocation(4,:));
                Screen('FillRect', w, Color5, ColorLocation(5,:));
                Screen('FillRect', w, Color6, ColorLocation(6,:));
                Screen('FillRect', w, Color7, ColorLocation(7,:));
                Screen('FillRect', w, Color8, ColorLocation(8,:));

                Screen('TextFont', w, 'Times'); %set text font
                Screen('TextSize', w,20 ); %set text size
                Screen('DrawText', w, 'a', LetterLoc(1,1),LetterLoc(1,2), [250 250 250]);
                Screen('DrawText', w, 's', LetterLoc(2,1),LetterLoc(2,2), [250 250 250]);
                Screen('DrawText', w, 'd', LetterLoc(3,1),LetterLoc(3,2), [250 250 250]);
                Screen('DrawText', w, 'f', LetterLoc(4,1),LetterLoc(4,2), [250 250 250]);
                Screen('DrawText', w, 'j', LetterLoc(5,1),LetterLoc(5,2), [250 250 250]);
                Screen('DrawText', w, 'k', LetterLoc(6,1),LetterLoc(6,2), [250 250 250]);
                Screen('DrawText', w, 'l', LetterLoc(7,1),LetterLoc(7,2), [250 250 250]);
                Screen('DrawText', w, ';', LetterLoc(8,1),LetterLoc(8,2),  [250 250 250]);
                
                Screen('DrawLine',w, white, screenXpixels/2-screenXpixels/20, screenYpixels/4, screenXpixels/2+screenXpixels/20 ,screenYpixels/4, 6);
                % horizontal line for prompt arrow
                
                if TargetArray(j) ==1 %left
                    Screen('DrawLine',w, white, screenXpixels/2-screenXpixels/20, screenYpixels/4, screenXpixels/2 ,screenYpixels/4+screenYpixels/20, 6);
                    Screen('DrawLine',w, white, screenXpixels/2-screenXpixels/20, screenYpixels/4, screenXpixels/2 ,screenYpixels/4-screenYpixels/20, 6);
                    % left arrowhead for prompt arrow
                    blockdata.expr(j) = ColorArray(TrialStat(1,j), 1);
                else %right
                    Screen('DrawLine',w, white, screenXpixels/2+screenXpixels/20, screenYpixels/4, screenXpixels/2 ,screenYpixels/4+screenYpixels/20, 6);
                    Screen('DrawLine',w, white, screenXpixels/2+screenXpixels/20, screenYpixels/4, screenXpixels/2 ,screenYpixels/4-screenYpixels/20, 6);
                    % right arrowhead for prompt arrow
                    blockdata.expr(j) = ColorArray(TrialStat(2,j), 1);
                end
                Screen('Flip', w);
                [keyIsDown,secs,keyCode]=KbCheck();
            end


            if (keyCode(KbName('a')))
                blockdata.resp(j) = 1;
            elseif (keyCode(KbName('s')))
                blockdata.resp(j) = 2;
            elseif (keyCode(KbName('d')))
                blockdata.resp(j) = 3;
            elseif (keyCode(KbName('f')))
                blockdata.resp(j) = 4;
            elseif (keyCode(KbName('j')))
                blockdata.resp(j) = 5;
            elseif (keyCode(KbName('k')))
                blockdata.resp(j) = 6;
            elseif (keyCode(KbName('l')))
                blockdata.resp(j) = 7;
            elseif (keyCode(KbName(';')))
                blockdata.resp(j) = 8;
            end


        end

        blockdata.acc = blockdata.resp == blockdata.expr;
        %MOVING TRIAL__________________________________________________________________________
        elseif TrialType == 2

            whichKeys = [KbName('a') KbName('s') KbName('d') KbName('f') KbName('j') KbName('k') KbName('l') KbName(';')];

            Screen('DrawText', w, ['Press any key to start'], screenXpixels/5, yCenter, white);
            Screen('Flip', w);
            KbStrokeWait; %Wait until a key press

            flipSpd = 2; %  a flip every 12 frames; higher number of frames --> slower

            monitorFlipInterval = Screen('GetFlipInterval', w);
            % retrieving screen flip interval of screen being used
            % 1/monitorFlipInterval is the frame rate of the monitor

           % black = BlackIndex(w); white = WhiteIndex(w); 







            %Here I'll set the locations of options for the response screen.
            squareSize = screenXpixels/16  ;
            [xCenter, yCenter] = RectCenter(rect);

            for i = 1:8
                ColorLocation(i,:) = [(screenXpixels*i/18)+(squareSize*(i-1)) , yCenter-squareSize/2, (screenXpixels*i/18 )+( squareSize*i), yCenter+squareSize/2 ];
                LetterLoc(i,:) = [(screenXpixels*i/18)+(squareSize*(i-1)) , yCenter+squareSize/2];
            end

            keypress=0;

            for j= 1:nTrial
                %Color information for each dot
                colorInfo1 = ColorArray(TrialMotion(1,j), 2:end);
                colorInfo2 = ColorArray(TrialMotion(2,j), 2:end);

                x1 = dot.LocationL(1);%dot.LocationL initial
                y1 = dot.LocationL(2);

                x2 = dot.LocationR(1); %dot.LocationR initial
                y2 = dot.LocationR(2);

                for i=1:round(stimDur/(flipSpd*monitorFlipInterval)) %to make it until you press a button

                    Screen('DrawLines', w, allCoords, 4, white, [xCenter yCenter]); %Fixation Cross              
                    Screen('FillOval', w , colorInfo1, [x1-dot.size y1-dot.size x1+dot.size y1+dot.size],2*dot.size);
                    %Start ball 1 at the center of left field
                    Screen('FillOval', w , colorInfo2, [x2-dot.size y2-dot.size x2+dot.size y2+dot.size],2*dot.size);
                    %Start ball 1 at the center of left field               
                    %start ball 2 at the center of right field
                    %Screen('Flip', w);
                    vbl = Screen('Flip', w, vbl+(flipSpd*monitorFlipInterval));

                    if i==1 % if first iteration of loop

                        dx1=(2*rand-1); dy1= (2*rand-1);
                        dx2=(2*rand-1); dy2=(2*rand-1);
                        %generates random initial trajectory of balls
                    end


                    %  dx2=(2*rand-1); dy2=(2*rand-1); %%
                    %uncomment above line to view different in movement of balls


                    x1 = x1+dot.velocity*dx1; y1 = y1+dot.velocity*dy1;
                    %calculate new position of ball 1
                    x2 = x2+dot.velocity*dx2; y2 = y2+dot.velocity*dy2;
                    %calculate new position of ball 2


                    theta1=atand(dy1/dx1);  theta2=atand(dy2/dx2);
                    %finds trajectory angle of change in position that just occured.
                    %returns value between 90deg - -90deg.
                    % atand() function does not specify which cartesian quadrant of trjectory.
                    % if theta value >0, dx&dy are both >0 or <0. (Quadrant 1 or 3)
                    % if theta value <0, either dx or dy are <0. (Quadrant 2 or 4)


                    if dx1 >=0 && dy1<0 %if trajectory vector in quadrant 4 of cartesian coords

                        theta1= 360+theta1;
                        %if in quadrant 4, theta1 will be returned as a negative value.
                        %subtracting theta 1 from 360 returns the positive equivalent value.

                    elseif dx1<0 %if trajectory vector in quadrant 2 or 3 of cartesian coords

                        theta1= 180+theta1;
                        %if theta1 is in quadrant 2 theta1 will be negative.
                        %if theta1 is in quadrant 3 theta will be positive.
                        % adding theta1 to 180degrees returns corresponding angle measured
                        % from the origin.

                    end
                    %if none of above if statements are fulfilled, theta1 is in quadrant 1.


                    if dx2 >=0 && dy2<0 %if trajectory vector in quadrant 4 of cartesian coords

                        theta2= 360+theta2;
                        %if in quadrant 4, theta2 will be returned as a negative value.
                        %subtracting theta2 from 360 returns the positive equivalent value.

                    elseif dx2<0 %if trajectory vector in quadrant 2 or 3 of cartesian coords

                        theta2= 180+theta2;
                        %if theta1 is in quadrant 2 theta1 will be negative.
                        %if theta1 is in quadrant 3 theta will be positive.
                        % adding theta1 to 180degrees returns corresponding angle measured
                        % from the origin.

                    end

                    theta1= (theta1+(45))-(90*rand); theta2= (theta2+(45))-(90*rand);
                    %creates trajectory angle for next 'movement' based on previous trajectory
                    %new trajectory will be within 45degrees clockwise or counter-clockwise
                    %of previous trajectory

                    dx1=cosd(theta1);  dx2=cosd(theta2);
                    %calculates x-component of trajectory unit vector

                    dy1=sind(theta1);   dy2=sind(theta2);
                    %calculates y-component of trajectory unit vector


                    %------------------------------------------------------------------
                    % x2 = max(x2, screenXpixels/2+100);
                    % x2 = min(x2, screenXpixels-r*2);
                    % y2 = max(y2, r*2);
                    % y2 = min(y2, screenYpixels-r);

                    %uncomment this section and comment out the next designated section to view
                    %difference movement as it reaches the boundaries
                    %------------------------------------------------------------------

                    if ((x1+dot.velocity*dx1) > (screenXpixels/2-100)) | ((x1+dot.velocity*dx1)< dot.size)
                        %if next movement will go beyond defined 'x' boundaries
                        dx1=dx1*(-1); % reverse direction of dx1 for a bounce effect
                    end

                    if ((y1+dot.velocity*dy1) > (screenYpixels-dot.size)) | ((y1+dot.velocity*dy1) < dot.size)
                        % if next move will go beyond defined 'y' boundaries
                        dy1=dy1*(-1); %reverse direction of dy1 for bounce effece
                    end

                    %------------------------------------------------------
                    %comment section below and uncomment designated section above to view
                    %difference of ball action as it reaches boundaries

                    if ((x2+dot.velocity*dx2) < (screenXpixels/2+100)) | ((x2+dot.velocity*dx2) > (screenXpixels-dot.size))
                        %     %if next movement will go beyond defined 'x' boundaries
                        dx2=dx2*(-1); % reverse direction of dx1 for a bounce effect
                    end

                    if ((y2+dot.velocity*dy2) > (screenYpixels-dot.size)) | ((y2+dot.velocity*dy2) < dot.size)
                        %     %if next move will go beyond defined 'y' boundaries
                        dy2=dy2*(-1); %reverse direction of dy1 for bounce effece
                    end
                    %-------------------------------------------------------------------

                end

                Screen('FillRect',w,black); %creating black screen
                Screen('DrawLines', w, allCoords, 4, white, [xCenter yCenter]); %Fixation Cross
                Screen('Flip', w);
                WaitSecs(ISI);

                Screen('FillRect',w,black); %creating black screen

                while(~KbCheck)
                    Screen('FillRect', w, Color1, ColorLocation(1,:));
                    Screen('FillRect', w, Color2, ColorLocation(2,:));
                    Screen('FillRect', w, Color3, ColorLocation(3,:));
                    Screen('FillRect', w, Color4, ColorLocation(4,:));
                    Screen('FillRect', w, Color5, ColorLocation(5,:));
                    Screen('FillRect', w, Color6, ColorLocation(6,:));
                    Screen('FillRect', w, Color7, ColorLocation(7,:));
                    Screen('FillRect', w, Color8, ColorLocation(8,:));

                    Screen('TextFont', w, 'Times'); %set text font
                    Screen('TextSize', w,20 ); %set text size
                    Screen('DrawText', w, 'a', LetterLoc(1,1),LetterLoc(1,2), [250 250 250]);
                    Screen('DrawText', w, 's', LetterLoc(2,1),LetterLoc(2,2), [250 250 250]);
                    Screen('DrawText', w, 'd', LetterLoc(3,1),LetterLoc(3,2), [250 250 250]);
                    Screen('DrawText', w, 'f', LetterLoc(4,1),LetterLoc(4,2), [250 250 250]);
                    Screen('DrawText', w, 'j', LetterLoc(5,1),LetterLoc(5,2), [250 250 250]);
                    Screen('DrawText', w, 'k', LetterLoc(6,1),LetterLoc(6,2), [250 250 250]);
                    Screen('DrawText', w, 'l', LetterLoc(7,1),LetterLoc(7,2), [250 250 250]);
                    Screen('DrawText', w, ';', LetterLoc(8,1),LetterLoc(8,2),  [250 250 250]);

                    Screen('DrawLine',w, white, screenXpixels/2-screenXpixels/20, screenYpixels/4, screenXpixels/2+screenXpixels/20 ,screenYpixels/4, 7);
                    % horizontal line for prompt arrow

                    if TargetArray(j) ==1 %left
                        Screen('DrawLine',w, white, screenXpixels/2-screenXpixels/20, screenYpixels/4, screenXpixels/2 ,screenYpixels/4+screenYpixels/20, 7);
                        Screen('DrawLine',w, white, screenXpixels/2-screenXpixels/20, screenYpixels/4, screenXpixels/2 ,screenYpixels/4-screenYpixels/20, 7);
                        % left arrowhead for prompt arrow
                        blockdata.expr(j) = ColorArray(TrialStat(1,j), 1);
                    else %right
                        Screen('DrawLine',w, white, screenXpixels/2+screenXpixels/20, screenYpixels/4, screenXpixels/2 ,screenYpixels/4+screenYpixels/20, 7);
                        Screen('DrawLine',w, white, screenXpixels/2+screenXpixels/20, screenYpixels/4, screenXpixels/2 ,screenYpixels/4-screenYpixels/20, 7);
                        % right arrowhead for prompt arrow
                        blockdata.expr(j) = ColorArray(TrialStat(2,j), 1);
                    end
                    Screen('Flip', w);
                    [keyIsDown,secs,keyCode]=KbCheck();
                end

                if (keyCode(KbName('a')))
                    blockdata.resp(j) = 1;
                elseif (keyCode(KbName('s')))
                    blockdata.resp(j) = 2;
                elseif (keyCode(KbName('d')))
                    blockdata.resp(j) = 3;
                elseif (keyCode(KbName('f')))
                    blockdata.resp(j) = 4;
                elseif (keyCode(KbName('j')))
                    blockdata.resp(j) = 5;
                elseif (keyCode(KbName('k')))
                    blockdata.resp(j) = 6;
                elseif (keyCode(KbName('l')))
                    blockdata.resp(j) = 7;
                elseif (keyCode(KbName(';')))
                    blockdata.resp(j) = 8;
                end

            end
            blockdata.acc = blockdata.resp == blockdata.expr;

    end
        
end

