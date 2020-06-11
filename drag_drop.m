function drag_drop
dragging = [];
orPos = [];
f = figure('WindowButtonUpFcn',@dropObject,'units','normalized','WindowButtonMotionFcn',@moveObject);
a = annotation('textbox','position',[0.2 0.2 0.2 0.2],'String','Hello','ButtonDownFcn',@dragObject);
    function dragObject(hObject,eventdata)
        dragging = hObject;
        orPos = get(gcf,'CurrentPoint');
    end
    function dropObject(hObject,eventdata)
        if ~isempty(dragging)
            newPos = get(gcf,'CurrentPoint');
            posDiff = newPos - orPos;
            set(dragging,'Position',get(dragging,'Position') + [posDiff(1:2) 0 0]);
            dragging = [];
        end
    end
    function moveObject(hObject,eventdata)
        if ~isempty(dragging)
            newPos = get(gcf,'CurrentPoint');
            posDiff = newPos - orPos;
            orPos = newPos;
            set(dragging,'Position',get(dragging,'Position') + [posDiff(1:2) 0 0]);
        end
    end
end