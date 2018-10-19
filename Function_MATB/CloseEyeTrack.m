function CloseEyeTrack(MATB_DATA)

for i=1:2
    client_socket{i}=MATB_DATA.EyeTrack.client_socket{i};
    fprintf(client_socket{i}, '<SET ID="ENABLE_SEND_DATA" STATE="0" />');
    fprintf(client_socket{i}, '<SET ID="TRACKER_DISPLAY" STATE ="0" />');
    fprintf(client_socket{i}, '<SET ID="ENABLE_SEND_POG_BEST" STATE="0" />');
    fprintf(client_socket{i}, '<SET ID="ENABLE_SEND_POG_LEFT" STATE="0" />');
    fprintf(client_socket{i}, '<SET ID="ENABLE_SEND_POG_RIGHT" STATE="0" />');
    fprintf(client_socket{i}, '<SET ID="ENABLE_SEND_POG_FIX" STATE="0" />');
    
    pause(0.5)
    while  (get(client_socket{i}, 'BytesAvailable') > 0)
        results = fscanf(client_socket{i});
        disp(results)
        pause(.01);
    end
end


