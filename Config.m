global MATB_DATA

%-------- SCENARIO -----------------------------------------------------------
MATB_DATA.Param.Tutorial = 0; % if 1 Execute Tutorial script
MATB_DATA.Param.Training = 0; % if 1 Execute Traning script

MATB_DATA.N_Scenario = 3;
MATB_DATA.ScenarioType=[0 0 1]; % Workload 0 = LOW ; 1 = HIGH
MATB_DATA.ScenarioDuration = [10 10 10]; % seconds (for each scenario)
%--------------------------------------------------------------------------

%-------- EVENT -----------------------------------------------------------
% 1. Program MATB events manually
EventManual

% 2. Automatize Event Generation (Event MATRIX)
% You can define the number of events you want for each scenario (line) 
% Each colum correspond to a task
% 1st COLUMN  = System monitoring (number of event : 1/3 for F5 and F6 and  2/3 for F1 to F4)
% 2nd COLUMN = Total number of comm(TARGET (own) and DISTRACTOR (others)
% 3nd COLUMN = Number of target comm (sould be lower than total)
% 4th COLUMN = Number of BROKEN pump event (last 30sec +- 5 sec)
% EventMatrix = [ 12 4 2 4; 
%                 12 4 2 4; 
%                 24 10 5 5];
% gen_EVENT(EventMatrix) % Automatically generate events
%--------------------------------------------------------------------------

%---- TRACK PARAMETERS : STRENGHT and SPEED -------------------------------
% if 1, Noise has same force as Joystick input. If lower noise is weaker.
% Speed of track in arbitrary unit 
% (its updated every 20ms, and the square size is 20x20 units)

% EASY PARAMETERS
MATB_DATA.Param.StrengthTrackNoise(1)   =  0.9;      
MATB_DATA.Param.TrackSpeed(1)           =  0.07;     
% HARD PARAMETERS
MATB_DATA.Param.StrengthTrackNoise(2)   =  1.10;
MATB_DATA.Param.TrackSpeed(2)           =  0.2;
%--------------------------------------------------------------------------

%---- DEPENDENCY Between Task ---------------------------------------------
% if 1, When track is out of big square all pump off
MATB_DATA.Param.PumpCloseTrack = 0; 
% if 1, when level are above 3000 or below 2000 TRACK is harder
MATB_DATA.Param.TrackIfLevel = 0;   
%--------------------------------------------------------------------------

%---- STREAMING -----------------------------------------------------------
MATB_DATA.LSL_Streaming = 0;        % if 1, Data Streamed via LSL
MATB_DATA.Param.CommActive = 1;     % if 1, COMM Task is active
%--------------------------------------------------------------------------

%---- EYE TRACKER ---------------------------------------------------------
MATB_DATA.GazepointEyeTracker = 0;                  % if 1, Gazepoint Active
MATB_DATA.Param.EyeTracker.IP = '10.161.8.134';     % Control Adress
MATB_DATA.Param.EyeTracker.PortNum{1} = 4242;       % Control Port
%--------------------------------------------------------------------------

%------- TODO
% Gestion Event avec PARAM
% Param de Flux
% Param de Comm
% Update Rate ?
MATB_DATA.Param.Retro = 0;
% Checker Config (N_Scenario Duree)



