%---------- Gestion Com Joystick
% function [MATB_DATA] = Update_JOYSTICKBUT(MATB_DATA, joy)
function Update_JOYSTICKBUT
global MATB_DATA

joy = MATB_DATA.TRACK.JoystickID;

ButPasse = {'NAV1' [3]; 'NAV2' [2]; 'COM1' [1]; 'COM2' [4]}; %!!!Rangé par ordre décroissant: le dernier créé est le premier dans la liste
DigIdx = {'NAV1' 9 8 24 27; 'NAV2' 7 6 20 23; 'COM1' 5 4 16 19; 'COM2' 3 2 12 15};

switch find(button(joy))
	case 1		
		set(MATB_DATA.MainFigure.Children(12:27), 'Visible','off');
		MATB_DATA.MainFigure.Children(11).Children(cell2mat(ButPasse(find(strcmp(ButPasse(:,1), MATB_DATA.MainFigure.Children(11).SelectedObject.String)),2))).Value = 1;
		set(MATB_DATA.MainFigure.Children(DigIdx{find(strcmp(MATB_DATA.MainFigure.Children(11).SelectedObject.String,...
			DigIdx(:,1))),4}:DigIdx{find(strcmp(MATB_DATA.MainFigure.Children(11).SelectedObject.String,...
			DigIdx(:,1))),5}), 'Visible','on');	
	case 2
		set(MATB_DATA.MainFigure.Children(11).Children,'Value',0)
		MATB_DATA.MainFigure.Children(11).Children(4).Value = 1; % Modifie AL
		set(MATB_DATA.MainFigure.Children(12:27), 'Visible','off');
		set(MATB_DATA.MainFigure.Children(24:27), 'Visible','on');
		send_log('COMM APPLY',['  NAV1:' get(MATB_DATA.MainFigure.Children(9), 'String') '.' get(MATB_DATA.MainFigure.Children(8), 'String') ,...
			'  NAV2:' get(MATB_DATA.MainFigure.Children(7), 'String') '.' get(MATB_DATA.MainFigure.Children(6), 'String') ,...
			'  COM1:' get(MATB_DATA.MainFigure.Children(5), 'String') '.' get(MATB_DATA.MainFigure.Children(4), 'String') ,...
			'  COM2:' get(MATB_DATA.MainFigure.Children(3), 'String') '.' get(MATB_DATA.MainFigure.Children(2), 'String')]);
		
		Value=cat(2, str2num(get(MATB_DATA.MainFigure.Children(9),'String')) + 0.001*str2num(get(MATB_DATA.MainFigure.Children(8),'String')),...
			str2num(get(MATB_DATA.MainFigure.Children(7),'String')) + 0.001*str2num(get(MATB_DATA.MainFigure.Children(6),'String')),...
			str2num(get(MATB_DATA.MainFigure.Children(5),'String')) + 0.001*str2num(get(MATB_DATA.MainFigure.Children(4),'String')),...
			str2num(get(MATB_DATA.MainFigure.Children(3),'String')) + 0.001*str2num(get(MATB_DATA.MainFigure.Children(2),'String')) );
		
        send_comm(Value)

	case 3
		value=str2num(get(MATB_DATA.MainFigure.Children(DigIdx{find(strcmp(MATB_DATA.MainFigure.Children(11).SelectedObject.String,...
			DigIdx(:,1))),2}), 'String'));
		set(MATB_DATA.MainFigure.Children(DigIdx{find(strcmp(MATB_DATA.MainFigure.Children(11).SelectedObject.String,...
			DigIdx(:,1))),2}), 'String', num2str(value-1));
	case 4
		value=str2num(get(MATB_DATA.MainFigure.Children(DigIdx{find(strcmp(MATB_DATA.MainFigure.Children(11).SelectedObject.String,...
			DigIdx(:,1))),3}), 'String'));
		set(MATB_DATA.MainFigure.Children(DigIdx{find(strcmp(MATB_DATA.MainFigure.Children(11).SelectedObject.String,...
			DigIdx(:,1))),3}), 'String', num2str(value-25));
	case 5
		value=str2num(get(MATB_DATA.MainFigure.Children(DigIdx{find(strcmp(MATB_DATA.MainFigure.Children(11).SelectedObject.String,...
			DigIdx(:,1))),2}), 'String'));
		set(MATB_DATA.MainFigure.Children(DigIdx{find(strcmp(MATB_DATA.MainFigure.Children(11).SelectedObject.String,...
			DigIdx(:,1))),2}), 'String', num2str(value+1));
	case 6
		value=str2num(get(MATB_DATA.MainFigure.Children(DigIdx{find(strcmp(MATB_DATA.MainFigure.Children(11).SelectedObject.String,...
			DigIdx(:,1))),3}), 'String'));
		set(MATB_DATA.MainFigure.Children(DigIdx{find(strcmp(MATB_DATA.MainFigure.Children(11).SelectedObject.String,...
			DigIdx(:,1))),3}), 'String', num2str(value+25));
end

MATB_DATA.LastUpdate.JS=GetSecs;