global MATB_DATA

%---- SCENARIO
MATB_DATA.Param.Training = 0;
MATB_DATA.Param.Tutorial = 0;

MATB_DATA.N_Scenario = 1;
MATB_DATA.ScenarioType=[ %Workload 0/1  avec 0 pour low workload, 1 pour high workload
    0 ];
MATB_DATA.ScenarioDuration = [20]; % In Second

%---- TRACK PARAMETERS : Force du Bruit et Vitesse
% Carre du TRACK
MATB_DATA.Param.StrengthTrackNoise(1)   =  0.9;      % if 1, Noise has same force as Joystick input. If lower noise is weaker. 
MATB_DATA.Param.TrackSpeed(1)           =  0.07;     % Speed of track in arbitrary unit
        
MATB_DATA.Param.StrengthTrackNoise(2)   =  1.10;
MATB_DATA.Param.TrackSpeed(2)           =  0.2; 

%---- DEPENDENCY Between Task
MATB_DATA.Param.PumpCloseTrack = 0; % if 1, When track is out of big square all pump off
MATB_DATA.Param.TrackIfLevel = 0;   % if 1, when level are above 3000 or below 2000 TRACK is harder

%---- STREAMING
MATB_DATA.LSL_Streaming = 0;        % if 1, Data Streamed via LSL
MATB_DATA.Param.CommActive = 1;     % if 1, COMM Task is active

%---- EYE TRACKER
MATB_DATA.GazepointEyeTracker = 0;                  % if 1, Gazepoint Active
MATB_DATA.Param.EyeTracker.IP = '10.161.8.134';     % Control Adress
MATB_DATA.Param.EyeTracker.PortNum{1} = 4242;       % Control Port



%------- TODO
% Gestion Event avec PARAM
% Param de Flux
% Param de Comm
% Update Rate ?
MATB_DATA.Param.Retro = 1;
% Checker Config (N_Scenario Duree)



