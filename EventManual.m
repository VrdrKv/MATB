global MATB_DATA
% % EVENT MATB
% 
% COMMUNICATION EVENTS should be at least seperated by 15 seconds
% BROKEN PUMP SHOULD BE REPAIRED at some point right ?
%               DEVIATION           
%            -1: LOW  1: UP    -1: Error         Pmp    -1:Broken     1:Repaired               1:Own -1:Others
%Seconds F1    F2    F3    F4    F5    F6     1     2     3    4     5     6     7      8   NAV1  NAV2   COM1  COM2
EVENT{1}=[
    1     1     0     0     0     0     0     0     0     0     0     0     0     0     0     0     0     0     0
    2     0     0     0     0     0     0     0     0     0     0     0     0     0     0     0     0     0     0
    3     -1    0     0     0     0     1     0     0     0     0     0     0     0     0     0     0     0     0
    4     0     1     0     0     0     0     0     0     0     0     0     0     0     0     0     0     0     0
    5     0     0     0     0     0     0     0     0     0     0     0     0     0     0     0     0     0     0
    6     0     0     0     0     0     0     0     0     0     0     0     0     0     0     0     0     0     0
    7     0     0     1     0     0     0     0     0     0     0     0     0     0     0     0     0     0     0
    8     0     0     0     0     0     0     0     0     0     0     0     0     0     0     0     0     0     0
    9     0     0     0     0     0     0     0     0     0     0     0     0     0     0     0     0     0     0
    10    0     0     0     1     0     1     0     0     0     0     0     0     0     0     0     0     0     0
    ];

EVENT{2}=[
    1     1     0     0     0     0     0     0     0     0     0     0     0     0     0     0     0     0     0
    2     0     0     0     0     0     0     0     0     0     0     0     0     0     0     0     0     0     0
    3     0     0     0     0     0     1     0     0     0     0     0     0     0     0     0     0     0     0
    4     0     1     0     0     0     0     0     0     0     0     0     0     0     0     0     0     0     0
    5     0     0     0     0     0     0     0     0     0     0     0     0     0     0     0     0     0     0
    6     0     0     0     0     0     0     0     0     0     0     0     0     0     0     0     0     0     0
    7     0     0     1     0     0     0     0     0     0     0     0     0     0     0     0     0     0     0
    8     0     0     0     0     0     0     0     0     0     0     0     0     0     0     0     0     0     0
    9     0     0     0     0     0     0     0     0     0     0     0     0     0     0     0     0     0     0
    10    0     0     0     1     0     1     0     0     0     0     0     0     0     0     0     0     0     0
    ];

EVENT{3}=[
    1     1     0     0     0     0     0     0     0     0     0     0     0     0     0     0     0     0     0
    2     0     0     0     0     0     0     0     0     0     0     0     0     0     0     0     0     0     0
    3     0     0     0     0     0     1     0     0     0     0     0     0     0     0     0     0     0     0
    4     0     1     0     0     0     0     0     0     0     0     0     0     0     0     0     0     0     0
    5     0     0     0     0     0     0     0     0     0     0     0     0     0     0     0     0     0     0
    6     0     0     0     0     0     0     0     0     0     0     0     0     0     0     0     0     0     0
    7     0     0     1     0     0     0     0     0     0     0     0     0     0     0     0     0     0     0
    8     0     0     0     0     0     0     0     0     0     0     0     0     0     0     0     0     0     0
    9     0     0     0     0     0     0     0     0     0     0     0     0     0     0     0     0     0     0
    10    0     0     0     1     0     1     0     0     0     0     0     0     0     0     0     0     0     0
    ];

MATB_DATA.RESMAN.FluxPompe{1}=[70 60 70 60 60 60 40 40 80 80]/3;  % PUMP FLOW
MATB_DATA.RESMAN.FluxPompe{2}=[70 60 70 60 60 60 40 40 80 80]/3;
MATB_DATA.RESMAN.FluxPompe{3}=[70 60 70 60 60 60 40 40 80 80]/3;

MATB_DATA.TRACK.Difficulty{1}=0; % Easy = 0 / Hard = 1
MATB_DATA.TRACK.Difficulty{2}=0;
MATB_DATA.TRACK.Difficulty{3}=0;

MATB_DATA.EVENT{1}=EVENT{1}; % Attribute EVENT into MATB_DATA
MATB_DATA.EVENT{2}=EVENT{2};
MATB_DATA.EVENT{3}=EVENT{3};
