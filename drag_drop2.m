figure
drawnow
while true
%     get(gcf,'CurrentPoint')
    get(gcf,'CurrentCharacter')
    pause(0.01)
end

%%
time = hat
b=hat - time
%%
figure('ButtonDownFcn',@dragObject)