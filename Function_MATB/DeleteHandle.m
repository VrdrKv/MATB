function DeleteHandle
global MATB_DATA
PsychHID('KbQueueStop'), PsychPortAudio('close', MATB_DATA.handlePortAudio)

if MATB_DATA.GazepointEyeTracker
    for i=1%:2
        fprintf(MATB_DATA.EyeTrack.client_socket{i},'<SET ID="ENABLE_SEND_DATA" STATE="0" />');
        fclose(MATB_DATA.EyeTrack.client_socket{i});
        delete(MATB_DATA.EyeTrack.client_socket{i});
    end
end
delete(get(0,'children'))