function [MATB_DATA]=Init_EYE_TRACK(MATB_DATA)

if MATB_DATA.GazepointEyeTracker
    try
        %------- CREATE FILE
        dt=char(datetime); dt([3 7 12 15 18])='_';
        MATB_DATA.ETfile_ID=fopen(['DATA/Eye_track_' dt '.txt'],'w');

        %------- SocketConnection
        % From gazepoint Control double clivk on server (Down)
        ip = '10.161.8.134';  % Control Adress
        portnum{1} = 4242; % Control Port
        portnum{2} = 4242;
        
        for i=1%:2 % Pour 2 eye tracker potentiellement

            client_socket{i}= tcpip(ip,portnum{i});
            set(client_socket{i}, 'InputBufferSize', 4096);
            
            try
                fopen(client_socket{i});
                
                client_socket{i}.Terminator = 'CR/LF';
                
                %----- GET ID
                fprintf(client_socket{i},'<GET ID="SERIAL_ID" />'); pause(0.5)
                while (get(client_socket{i}, 'BytesAvailable') > 0)
                    results = fscanf(client_socket{i});
                    disp(results)
                    pause(.01);
                end
                
                %----- Create New Calibration Point
                %--------------------
                %    x4   x7   x3
                %
                %    x6   x1   x8
                %
                %    x5   x9   x2
                %--------------------
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
                
            catch ME
                disp(['Problem with EyeTrack ' num2str(i) ' ' ME.message])
            end
            
            %     MATB_DATA.EyeTrack.outlet=outlet;
            MATB_DATA.EyeTrack.client_socket{i}=client_socket{i};
        end
    catch
        warning('Be sure to have EyeTracker Connected')
    end
end

