%%  感測定実験
clear all

dt = char(datetime('now','Format','yyyy-MM-dd''T''HHmmss'));
sn = input('Observer initial?: ','s');
datafilename = sprintf('../data/%s_%s.mat', sn, dt);

% AssertOpenGL;
ListenChar(2);
bgColor = [0 0 0];
screenWidth = 1920;
screenHeight = 1200;
screenNumber=max(Screen('Screens'));
InitializeMatlabOpenGL;

try
    %% set window
    PsychImaging('PrepareConfiguration');
    PsychImaging('AddTask', 'General', 'FloatingPoint32BitIfPossible');
    [windowPtr, windowRect] = PsychImaging('OpenWindow', screenNumber, 0);
    %[windowPtr, windowRect] = Screen('OpenWindow', screenvicNumber, bgColor, [0 0 screenWidth screenHeight]);
    Priority(MaxPriority(windowPtr));
    [offwin1,offwinrect]=Screen('OpenOffscreenWindow',windowPtr, 0);
    
    
    FlipInterval = Screen('GetFlipInterval', windowPtr); % モニタ１フレームの時間
    RefleshRate = 1./FlipInterval; % モニタ
    HideCursor(screenNumber);

    %% Key 
    myKeyCheck;
    escapeKey = KbName('ESCAPE');
    leftKey = KbName('LeftArrow');
    rightKey = KbName('RightArrow');
    

    
    SetMouse(screenWidth/2,screenHeight/2,screenNumber);

    %% display initial text
    Screen('TextSize', windowPtr, 35);
    startText = ['Click to start'];
    DrawFormattedText(windowPtr, startText, 'center', 'center', [255 255 255]);
    Screen('Flip', windowPtr);
    [clicks,x,y,whichButton] = GetClicks(windowPtr,0);
    Screen('Flip', windowPtr);
    WaitSecs(2);
    
    %% set parameter
    ix = 600;
    iy = 800;
    [mx,my] = RectCenter(windowRect);
    distance = 400;
    scale = 1;
    intervalTime = 1;
    leftPosition = [mx-ix-distance/2, my-iy/2, mx-distance/2, my+iy/2]; 
    rightPosition = [mx+distance/2, my-iy/2, mx+ix+distance/2, my+iy/2];
    
    totalSession = 10;
    
    %% expect (12-1)^2(env combination) * 5(color) * 3(material) images
    color = ["gray","red","yellow","green","blue"]; % 
    materal = ["m","p","c"];  % matte, plastic, conductor    
            
    %% main program
    
    for i = 1:1
        SetMouse(screenWidth/2,screenHeight/2,screenNumber);

        while true
            [x,y,buttons] = GetMouse;
            DrawFormattedText(windowPtr, num2str(x), 'center', 'center', [255 255 255]);

            Screen('FillRect', windowPtr, [100 100 100], leftPosition);
            Screen('FillRect', windowPtr, [255 255 255], rightPosition);
            Screen('Flip', windowPtr);

            if buttons(1) == 1
                break;
            end
            [keyIsDown, secs, keyCode, deltaSecs] = KbCheck([]);
            if keyCode(escapeKey)
                error('escape key is pressed.');
            end
            
        end
        Screen('Flip', windowPtr);
        WaitSecs(intervalTime);
    end
    
    finishText = 'The experiment is over.';
    DrawFormattedText(windowPtr, finishText, 'center', 'center', [255 255 255]);
    Screen('Flip', windowPtr);
    [clicks,x,y,whichButton] = GetClicks(windowPtr,0);
    

    Screen('CloseAll');
    ShowCursor;
    ListenChar(0);

catch
    Screen('CloseAll');
    ShowCursor;
    ListenChar(0);
    psychrethrow(psychlasterror);
end