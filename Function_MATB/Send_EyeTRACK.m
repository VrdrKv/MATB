function [MATB_DATA]=Send_EyeTRACK(MATB_DATA)

outlet=MATB_DATA.EyeTrack.outlet;

gx=zeros(2,1);
gy=zeros(2,1);
for i=1:2
    data = fscanf(MATB_DATA.EyeTrack.client_socket{i});
    %     if (get(client_socket{1}, 'BytesAvailable') > 0)
    %         disp(['Data 1 : ' data])
    %     end
    %     if (get(client_socket{2}, 'BytesAvailable') > 0)
    %         disp(['Data 2 : ' data])
    %     end
    c = '<REC />';
    if strncmp(data, c, 7)
        fprintf('waiting for EyeTrack...\n');
    else
        try
            split = strsplit(data,'"');
            GX = split(2);
            GY = split(4);
            gx(i) = str2double(char(GX));
            gy(i) = str2double(char(GY));
%             disp([num2str(gx) ' ' num2str(gy)])
        catch ex
%             rethrow(ex);
        end
    end
end
% cat(1,gx,gy)
outlet.push_sample(cat(1,gx,gy));