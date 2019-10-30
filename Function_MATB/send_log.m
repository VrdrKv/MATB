function send_log(Indic,Valeur)

global MATB_DATA

% str=[num2str(GetSecs) '\t\t' num2str(GetSecs-Start)  '\t\t\t'  Indic  '\t ' Valeur '\n' ];
% fprintf(fileID,str); outlet.push_sample({num2str(GetSecs-Start),Indic,Valeur});
% fprintf(fileID,'%.4f \t\t %.4f \t\t\t %s \t\t %s \n',GetSecs,GetSecs-Start,Indic,Valeur);

fprintf(MATB_DATA.LogFileID,'%s\t\t %.4f \t\t\t %s \t\t %s \n',char(datetime('now','Format','HH:mm:ss')),GetSecs-MATB_DATA.ScenarioStartedAt,Indic,Valeur);
if MATB_DATA.LSL_Streaming
    MATB_DATA.LSLoutlet.push_sample({num2str(GetSecs-MATB_DATA.ScenarioStartedAt),Indic,Valeur});
end