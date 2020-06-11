function Update_SYSMON
global MATB_DATA

POS=randi(3,1,4)-2; %Er=[-1 1];
MATB_DATA.SYSMON.Alarm(1).YData=[4 7 7 4]+POS(1)+MATB_DATA.SYSMON.EtatAlarm(1,1)*3*MATB_DATA.SYSMON.EtatAlarm(1,2);
MATB_DATA.SYSMON.Alarm(2).YData=[4 7 7 4]+POS(2)+MATB_DATA.SYSMON.EtatAlarm(2,1)*3*MATB_DATA.SYSMON.EtatAlarm(2,2);
MATB_DATA.SYSMON.Alarm(3).YData=[4 7 7 4]+POS(3)+MATB_DATA.SYSMON.EtatAlarm(3,1)*3*MATB_DATA.SYSMON.EtatAlarm(3,2);
MATB_DATA.SYSMON.Alarm(4).YData=[4 7 7 4]+POS(4)+MATB_DATA.SYSMON.EtatAlarm(4,1)*3*MATB_DATA.SYSMON.EtatAlarm(4,2);

MATB_DATA.SYSMON.PointeurAlarm(1).Position(2)=MATB_DATA.SYSMON.Alarm(1).YData(1)+1.5;
MATB_DATA.SYSMON.PointeurAlarm(2).Position(2)=MATB_DATA.SYSMON.Alarm(2).YData(1)+1.5;
MATB_DATA.SYSMON.PointeurAlarm(3).Position(2)=MATB_DATA.SYSMON.Alarm(3).YData(1)+1.5;
MATB_DATA.SYSMON.PointeurAlarm(4).Position(2)=MATB_DATA.SYSMON.Alarm(4).YData(1)+1.5;

if MATB_DATA.SYSMON.EtatAlarm(5)
    set(MATB_DATA.SYSMON.Alarm(5),'FaceColor',[0.94 0.94 0.94])
else
    set(MATB_DATA.SYSMON.Alarm(5),'FaceColor',[0 1 0])
end
if MATB_DATA.SYSMON.EtatAlarm(6)
    set(MATB_DATA.SYSMON.Alarm(6),'FaceColor',[1 0 0])
else
    set(MATB_DATA.SYSMON.Alarm(6),'FaceColor',[0.94 0.94 0.94])
end

% if all(get(MATB_DATA.SYSMON.Alarm(5),'backgroundcolor')==[0.94 0.94 0.94])
%     MATB_DATA.SYSMON.EtatAlarm(5)=1;
% end
% if all(get(MATB_DATA.SYSMON.Alarm(6),'backgroundcolor')==[1 0 0])
%     MATB_DATA.SYSMON.EtatAlarm(6)=1;
% end

MATB_DATA.LastUpdate.SYSMON=hat;

