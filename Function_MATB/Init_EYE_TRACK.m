function [MATB_DATA]=Init_EYE_TRACK(MATB_DATA)

% disp('Creating EyeTracking stream info...');
% info = lsl_streaminfo(lib,'GazePoint','EyeTrack',4,60,'cf_float32','sdfwerr32432');
% outlet = lsl_outlet(info);

for i=1:2
    %------- SocketConnection
    ip = '192.168.0.1';
    portnum{1} = 4241;
    portnum{2} = 4242;
    
    client_socket{i}= tcpip(ip,portnum{i});
    set(client_socket{i}, 'InputBufferSize', 4096);
    
    try
        fopen(client_socket{i});
        
        client_socket{i}.Terminator = 'CR/LF';
        
        %-----GET ID
        fprintf(client_socket{i},'<GET ID="SERIAL_ID" />'); pause(0.5)
        while (get(client_socket{i}, 'BytesAvailable') > 0)
            results = fscanf(client_socket{i});
            disp(results)
            pause(.01);
        end
        
    catch ME
        disp(['Problem with EyeTrack ' num2str(i) ' ' ME.message])
    end
    
%     MATB_DATA.EyeTrack.outlet=outlet;
    MATB_DATA.EyeTrack.client_socket{i}=client_socket{i};
end


