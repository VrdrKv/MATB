function [MATB_DATA]=Calibrate(MATB_DATA,i)

client_socket{i}=MATB_DATA.EyeTrack.client_socket{i};

fprintf(client_socket{i}, '<SET ID="CALIBRATE_SHOW" STATE="1" />');
fprintf(client_socket{i}, '<SET ID="CALIBRATE_START" STATE="1" />');
pause(25);
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

disp(['Ok Tracker : ' num2str(i)])
