
global MATB_DATA

MATB_DATA.LSL_Streaming = 0;        % if 1, Data Streamed via LSL

MATB_DATA.N_Scenario = 2;

MATB_DATA.ScenarioType=[ %Workload 0/1  avec 0 pour low workload, 1 pour high workload
    0 
    1];
MATB_DATA.ScenarioDuration = [20 20]; % In Second

MATB_DATA.Param.Training = 0;
MATB_DATA.Param.Tutorial = 0;

MATB_DATA.Param.PumpCloseTrack = 0; % if 1, When track is out of big square all pump off
MATB_DATA.Param.TrackIfLevel = 0;   % if 1, when level are above 3000 or below 2000 TRACK is harder
MATB_DATA.Param.CommActive = 1;     % if 1, COMM Task is active

MATB_DATA.GazepointEyeTracker = 0;  % if 1, Double Gazepoint Active


%------- TODO
% IP Eye Tracker

% Gestion Event avec PARAM

% Param de Track Force vitesse
% Param de Flux
% Param de Comm

% Checker Config (N_Scenario Duree)



