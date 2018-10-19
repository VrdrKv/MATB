function LaunchEyeTrack(MATB_DATA)

for i=1:2
    client_socket{i}=MATB_DATA.EyeTrack.client_socket{i};
    fprintf(client_socket{i}, '<SET ID="ENABLE_SEND_DATA" STATE="1" />');
    fprintf(client_socket{i}, '<SET ID="TRACKER_DISPLAY" STATE ="1" />');
    fprintf(client_socket{i}, '<SET ID="ENABLE_SEND_POG_BEST" STATE="1" />');
    fprintf(client_socket{i}, '<SET ID="ENABLE_SEND_POG_LEFT" STATE="1" />');
    fprintf(client_socket{i}, '<SET ID="ENABLE_SEND_POG_RIGHT" STATE="1" />');
    fprintf(client_socket{i}, '<SET ID="ENABLE_SEND_POG_FIX" STATE="1" />');
end


