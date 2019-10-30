% Init LOG
function Init_LOG
global MATB_DATA 
dt=char(datetime); dt([3 7 12 15 18])='_';
fileID=fopen(['LOG/log_' dt '.txt'],'w');

diary(['LOG/diary_' dt '.txt'])

fprintf(fileID,['# ', char(datetime) '\n',...
'#\n',...
'#\n',...
'#\n',...
'#DATE      RelativeTime            EVENT       ACTION \n'...
'#-------------------------------------------------------------------------------------------------------\n']);

% fprintf(fileID,'%.4f \t\t %.4f \t\t\t %s \n',char(datetime('now','Format','HH:mm:ss')),0,'INITIALIZING'); 
fprintf(fileID,'%s\t\t %.4f \t\t\t %s \n',char(datetime('now','Format','HH:mm:ss')),0,'INITIALIZING'); 
% fprintf(fileID,[num2str(GetSecs) '\t\t' num2str(0)  '\t\t\t' ' Intializing \n' ]);
% fclose(fileID);

MATB_DATA.LogFileID=fileID;