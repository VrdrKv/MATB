function Send_EyeTRACK
global Start MATB_DATA
if MATB_DATA.GazepointEyeTracker

    for i=1%:2 2 eye track ?
        data = fscanf(MATB_DATA.EyeTrack.client_socket{i});
        if (get(MATB_DATA.EyeTrack.client_socket{1}, 'BytesAvailable') > 0)
            disp(['Data 1 : ' data])
        end
        %                 if (get(client_socket{2}, 'BytesAvailable') > 0)
        %                     disp(['Data 2 : ' data])
        %                 end
        c = '<REC />';
        if strncmp(data, c, 7)
            fprintf('waiting for EyeTrack...\n');
        else
            try
                split = strsplit(data,'"');
                %  FIX LEFT RIGHT BEST  / (x,y,validity) times Resolution
                D{i}=str2double(split([2 4 12 14 16 18 20 22 24 26 28 30]))' .* repmat([ 1920 1080 1 ]',4,1);
            catch ex
                %             rethrow(ex);
            end
        end
    end
   
    D{1} = round(max(0,D{1})); % On suprrime les valeurs negatives et on arrondi au pixels
    fprintf(MATB_DATA.ETfile_ID,['%s\t\t %.4f \t\t\t %s \t\t ' repmat('%i\t' ,1,12) ' \n'],...
        char(datetime('now','Format','HH:mm:ss')),GetSecs-Start,'EyeTrack 1',D{1});
    if MATB_DATA.LSL_Streaming
        %     outlet.push_sample(cat(1,D{1},D{2}));
        outlet=MATB_DATA.EyeTrack.outlet;
        outlet.push_sample(D{1});
    end
end