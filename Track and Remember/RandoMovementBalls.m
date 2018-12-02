%RandoMovementBalls

Screen('Preference', 'SkipSyncTests', 0); 

screenNum=0; % setting a variable, which is the screen number

res=[0 0 800 600]; % setting size of window to be displayed


[w,rect] = Screen('OpenWindow',screenNum, 0, res);
% opening a new window to be displayed
% w is a windowPtr and specifies a screen to be displayed and referenced
% rect specifies coordinates of screen to be displayed starting from 
%     top left corner as origin


black = BlackIndex(w); white = WhiteIndex(w);
% Same as in ScreenBlackWhite.m
% creating shorcut to set screen to black or white

[xCenter, yCenter] = RectCenter(rect);

r=20; %radius of ball
v=4; % velocity of ball


Screen('FillRect',w,black); %creating black screen 

[screenXpixels, screenYpixels] = Screen('WindowSize', w);

x1 = screenXpixels/4;%dot.LocationL initial
y1 = screenYpixels/2;

x2 = screenXpixels*3/4; %dot.LocationR initial 
y2 = screenYpixels/2;

keypress = 0;
count=0; %variable for first loop if statement to only execute once 
%for initial trajectory

while(~KbCheck) %to make it until you press a button
     
Screen('DrawDots', w , [x1,y1], r, white, [0 0], 1); 
%Start ball 1 at the center of left field
Screen('DrawDots', w, [x2, y2], r, white, [0 0], 1);
%start ball 2 at the center of right field
Screen('Flip', w);

if count==0 % if first iteration of loop
    
    dx1=(2*rand-1); dy1= (2*rand-1);
    dx2=(2*rand-1); dy2=(2*rand-1);
    %generates random initial trajectory of balls    
    count=count+1;
end


%dx2=(2*rand-1); dy2=(2*rand-1); %% unc
%uncomment above line to view different in movement of balls


x1 = x1+v*dx1; y1 = y1+v*dy1; 
%calculate new position of ball 1
x2 = x2+v*dx2; y2 = y2+v*dy2;
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

if ((x1+v*dx1) > (screenXpixels/2-100)) | ((x1+v*dx1)< r) 
    %if next movement will go beyond defined 'x' boundaries
    dx1=dx1*(-1); % reverse direction of dx1 for a bounce effect
end

if ((y1+v*dy1) > (screenYpixels-r)) | ((y1+v*dy1) < r)
    % if next move will go beyond defined 'y' boundaries
    dy1=dy1*(-1); %reverse direction of dy1 for bounce effece
end

%------------------------------------------------------
%comment section below and uncomment designated section above to view
%difference of ball action as it reaches boundaries

if ((x2+v*dx2) < (screenXpixels/2+100)) | ((x2+v*dx2) > (screenXpixels-r)) 
    %if next movement will go beyond defined 'x' boundaries
    dx2=dx2*(-1); % reverse direction of dx1 for a bounce effect
end

if ((y2+v*dy2) > (screenYpixels-r)) | ((y2+v*dy2) < r)
    % if next move will go beyond defined 'y' boundaries
    dy2=dy2*(-1); %reverse direction of dy1 for bounce effece
end
%-------------------------------------------------------------------
 
keypress=KbCheck;
end

 



sca