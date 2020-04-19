function [MATB_DATA]=Send_EyeTRACK(MATB_DATA)

if MATB_DATA.GazepointEyeTracker
    outlet=MATB_DATA.EyeTrack.outlet;
    
    for i=1:2
        data = fscanf(MATB_DATA.EyeTrack.client_socket{i});
        %         if (get(client_socket{1}, 'BytesAvailable') > 0)
        %             disp(['Data 1 : ' data])
        %         end
        %         if (get(client_socket{2}, 'BytesAvailable') > 0)
        %             disp(['Data 2 : ' data])
        %         end
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
    outlet.push_sample(cat(1,D{1},D{2}));
end