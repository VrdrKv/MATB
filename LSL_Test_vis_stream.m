clear
addpath(genpath('D:\k.verdiere\Documents\MATLAB\labstreaminglayer'))

% instantiate the library
disp('Loading library...');
lib = lsl_loadlib();

% make a new stream outlet
disp('Creating a new streaminfo...');
info  = lsl_streaminfo(lib,'Kev', 'EEG',8,50,'cf_float32','sdfwerr32432');
% info  = lsl_streaminfo(lib,'Kev', 'EEG');
info2 = lsl_streaminfo(lib,'Kev2','EEG',8,50,'cf_float32','mdfkhjizejio');

disp('Opening an outlet...');
outlet  = lsl_outlet(info);
outlet2 = lsl_outlet(info2);

% send data into the outlet, sample by sample
disp('Now transmitting data...');
while true
    outlet.push_sample(rand(8,1));
    outlet2.push_sample(rand(8,1));
%     pause(0.1);
end