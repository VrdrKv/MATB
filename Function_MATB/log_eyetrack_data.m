function log_eyetrack_data(Indic,Valeur)

global fileID Start  MATB_DATA

% str=[num2str(hat) '\t\t' num2str(hat-Start)  '\t\t\t'  Indic  '\t ' Valeur '\n' ];
% fprintf(fileID,str); outlet.push_sample({num2str(hat-Start),Indic,Valeur});
% fprintf(fileID,'%.4f \t\t %.4f \t\t\t %s \t\t %s \n',hat,hat-Start,Indic,Valeur);

fprintf(fileID,'%s\t\t %.4f \t\t\t %s \t\t %s \n',char(datetime('now','Format','HH:mm:ss')),hat-Start,Indic,Valeur);
