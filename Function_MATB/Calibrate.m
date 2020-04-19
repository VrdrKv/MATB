function [MATB_DATA]=Calibrate(MATB_DATA,i)

yesKeys = KbName('Return');
noKeys  = KbName('Escape');
DoCalib=1;
Calib=0;

while DoCalib==1
    Calib=Calib+1;
    
    client_socket{i}=MATB_DATA.EyeTrack.client_socket{i};
    
    fprintf(client_socket{i}, '<SET ID="CALIBRATE_SHOW" STATE="1" />');
    fprintf(client_socket{i}, '<SET ID="CALIBRATE_START" STATE="1" />');
    pause(22);
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
    
    Resp=0;
    
    pop=dialog('position',[500   450   850   250]);
    txt = uicontrol('Parent',pop,...
        'Style','text',...
        'Position', [1 -100 850 250],...
        'String',['Are you happy with Calibration ' num2str(Calib) ' ? Yes=Enter / No=Escape'],...
        'Fontsize',18);
    drawnow
    
    while Resp==0
        [~,~,keyCode] = KbCheck;
        if keyCode(yesKeys)
            DoCalib=0; Resp=1; close(pop)
        end
        if keyCode(noKeys)
            Resp=1; close(pop)
        end
    end
    
end










