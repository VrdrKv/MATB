function LaunchEyeTrack(MATB_DATA)

for i=1%:2 For 2 eye track potentialy
    client_socket{i}=MATB_DATA.EyeTrack.client_socket{i};
    fprintf(client_socket{i}, '<SET ID="ENABLE_SEND_DATA" STATE="1" />');
    fprintf(client_socket{i}, '<SET ID="TRACKER_DISPLAY" STATE ="1" />');
    fprintf(client_socket{i}, '<SET ID="ENABLE_SEND_POG_BEST" STATE="1" />');
    fprintf(client_socket{i}, '<SET ID="ENABLE_SEND_POG_LEFT" STATE="1" />');
    fprintf(client_socket{i}, '<SET ID="ENABLE_SEND_POG_RIGHT" STATE="1" />');
    fprintf(client_socket{i}, '<SET ID="ENABLE_SEND_POG_FIX" STATE="1" />');
    
    c = '<REC />';
    pause(0.5)
    while  (get(client_socket{i}, 'BytesAvailable') > 0)
        data = fscanf(MATB_DATA.EyeTrack.client_socket{i});
        if strncmp(data, c, 7)
            disp(['Data Coming from EyeTrack ' num2str(i) ' ...'])
            break
        end
    end
end


