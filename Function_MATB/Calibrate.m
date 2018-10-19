function [MATB_DATA]=Calibrate(MATB_DATA,i)
%--------------------
%    x4   x7   x3
%
%    x6   x1   x8
%
%    x5   x9   x2
%--------------------
client_socket{i}=MATB_DATA.EyeTrack.client_socket{i};

fprintf(client_socket{i}, '<SET ID="CALIBRATE_CLEAR" />');

fprintf(client_socket{i}, '<SET ID="CALIBRATE_ADDPOINT" X="0.15" Y="0.5" />'); % X6
fprintf(client_socket{i}, '<SET ID="CALIBRATE_ADDPOINT" X="0.15" Y="0.85" />'); % X4
fprintf(client_socket{i}, '<SET ID="CALIBRATE_ADDPOINT" X="0.5"  Y="0.85" />'); % X7
fprintf(client_socket{i}, '<SET ID="CALIBRATE_ADDPOINT" X="0.85" Y="0.85" />'); % X3
fprintf(client_socket{i}, '<SET ID="CALIBRATE_ADDPOINT" X="0.5"  Y="0.5" />'); % X1
fprintf(client_socket{i}, '<SET ID="CALIBRATE_ADDPOINT" X="0.15" Y="0.15" />'); % X5
fprintf(client_socket{i}, '<SET ID="CALIBRATE_ADDPOINT" X="0.5"  Y="0.15" />'); % X9
fprintf(client_socket{i}, '<SET ID="CALIBRATE_ADDPOINT" X="0.85" Y="0.15" />'); % X2
fprintf(client_socket{i}, '<SET ID="CALIBRATE_ADDPOINT" X="0.85" Y="0.5" />'); % X8

fprintf(client_socket{i}, '<GET ID="CALIBRATE_ADDPOINT" />'); pause(0.5)
while  (get(client_socket{i}, 'BytesAvailable') > 0)
    results = fscanf(client_socket{i});
    disp(results)
    pause(.01);
end

fprintf(client_socket{i}, '<SET ID="CALIBRATE_SHOW" STATE="1" />');
fprintf(client_socket{i}, '<SET ID="CALIBRATE_START" STATE="1" />');
pause(30);
fprintf(client_socket{i}, '<SET ID="CALIBRATE_SHOW" STATE="0" />');
fprintf(client_socket{i}, '<SET ID="CALIBRATE_START" STATE="0" />');
fprintf(client_socket{i}, '<SET ID="ENABLE_SEND_DATA" STATE="0" />');
fprintf(client_socket{i}, '<GET ID="CALIBRATE_RESULT_SUMMARY" />');

pause(0.5)
while  (get(client_socket{i}, 'BytesAvailable') > 0)
    results = fscanf(client_socket{i});
    disp(results)
    pause(.01);
end

fprintf(client_socket{i}, '<SET ID="ENABLE_SEND_DATA" STATE="1" />');
fprintf(client_socket{i}, '<SET ID="TRACKER_DISPLAY" STATE ="1" />');
fprintf(client_socket{i}, '<SET ID="ENABLE_SEND_POG_BEST" STATE="1" />');

pause(0.5)
while  (get(client_socket{i}, 'BytesAvailable') > 0)
    results = fscanf(client_socket{i});
    disp(results)
    pause(.01);
end

disp(['Ok Tracker : ' num2str(i)])
