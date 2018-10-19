
function [MATB_DATA]=Init_LSL(MATB_DATA)
global fileID outlet

disp('Loading library...');
lib = lsl_loadlib();
% % make a new stream outlet
% % the name (here LSLMarkers) is visible to the experimenter and should be chosen so that
% % it is clearly recognizable as your MATLAB software's marker stream
% % The content-type should be Markers by convention, and the next three arguments indicate the
% % data format (1 channel, irregular rate, string-formatted).
% % The so-called source id is an optional string that allows for uniquely identifying your
% % marker stream across re-starts (or crashes) of your script (i.e., after a crash of your script
% % other programs could continue to record from the stream with only a minor interruption).

%%---------- MATB
disp('Creating MATB stream info...');
info = lsl_streaminfo(lib,'MATB','Markers',3,0,'cf_string','myID_MATB');
outlet = lsl_outlet(info);
MATB_DATA.LSLoutlet=outlet;

% fprintf(fileID,'%.4f \t\t %.4f \t\t\t %s \n',char(datetime('now','Format','HH:mm:ss')),0,'LAB STREAMING LAYER INIT'); 
fprintf(fileID,'%s\t\t %.4f \t\t\t %s \n',char(datetime('now','Format','HH:mm:ss')),0,'LAB STREAMING LAYER INIT'); 
outlet.push_sample({0,'LSL Init',''});

%%---------- EYE TRACKING
disp('Creating EyeTracking stream info...');
info = lsl_streaminfo(lib,'GazePoint','EyeTrack',4,60,'cf_float32','sdfwerr32432');
outlet2 = lsl_outlet(info);
MATB_DATA.EyeTrack.outlet=outlet2;

disp('Now transmitting data...');