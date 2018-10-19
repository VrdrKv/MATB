
[k,p,al]=GetKeyboardIndices

%% TEST KB QUEUE CHECK
fprintf('1 of 6.  Testing KbQueueCheck and KbName: press a key to see its number.\n');
fprintf('Press the escape key to proceed to the next demo.\n');
escapeKey = KbName('ESCAPE');
deviceIndex=[];
KbQueueCreate(deviceIndex);
while KbCheck; end % Wait until all keys are released.

KbQueueStart(deviceIndex);

while 1
    % Check the queue for key presses.
    [ pressed, firstPress]=KbQueueCheck(deviceIndex);

    % If the user has pressed a key, then display its code number and name.
    if pressed

        % Note that we use find(firstPress) because firstPress is an array with
        % zero values for unpressed keys and non-zero values for pressed keys
        %
        % The fprintf statement implicitly assumes that only one key will have
        % been pressed. If this assumption is not correct, an error will result

        fprintf('You pressed key %i which is %s\n', min(find(firstPress)), KbName(min(find(firstPress))));

        if firstPress(escapeKey)
            break;
        end
    end
end
KbQueueRelease(deviceIndex);
return


%%
KbName('UnifyKeyNames');
escapeKey = KbName('ESCAPE');
ListenChar(2)
while 1
    % Check the state of the keyboard.
    [ keyIsDown, seconds, keyCode ] = KbCheck;
    keyCode = find(keyCode, 1);
    if keyIsDown
        disp(KbName(keyCode))
        KbReleaseWait;
    end
    
    % If the user is pressing a key, then display its code number and name.
    %     if keyIsDown
    %         % Note that we use find(keyCode) becaxuse keyCode is an array.
    %         % See 'help KbCheck'ddddddd
    %         fprintf('You pressed key %i which is %s\n', keyCode, KbName(keyCode));
    %
    %         if keyCode == escapeKey
    %             break;
    %         end
    %
    %         % If the user holds down a key, KbCheck will report multiple events.
    %         % To condense multiple 'keyDown' events into a single event, we wait until all
    %         % keys have been released.
    %         KbReleaseWait;
    %     end
end

%%
KbName('UnifyKeyNames');
% ListenChar(-1)
while true
    [ keyIsDown1, ~, keyCode1 ] = KbCheck(7);
    keyIsDown2=0;
    %     [ keyIsDown2, ~, keyCode2 ] = KbCheck(9);
    
    keyCode1 = find(keyCode1, 1);
    %     keyCode2 = find(keyCode2, 1);cqsf
    
    
    if keyIsDown1 %|| keyIsDown2
        if keyIsDown1
            Kb=1
            KeyName=KbName(keyCode1);
            %         else if keyIsDown2
            %             Kb=2
            %             KeyName=KbName(keyCode2);
            %             end
        end
        
        KeyName
    end
    KbReleaseWait;
%     pause(0.01)
end
%%
FlushEvents
KbName('UnifyKeyNames');
% ListenChar(-1)
Serial=7
KbQueueCreate(Serial)
KbQueueStart(Serial)
while true
    [ keyIsDown1,~,~,keyCode1] = KbQueueCheck(Serial);
    %     [ keyIsDown2, ~, keyCode2 ] = KbCheck(4);
    
    keyCode1 = find(keyCode1, 1);
    %     keyCode2 = find(keyCode2, 1);
    
    
    if keyIsDown1% || keyIsDown2
        if keyIsDown1
            Kb=1
            KeyName=KbName(keyCode1);
            %         else
            %             kb=2
            %             KeyName=KbName(keyCode2);
        end
        
        KeyName
    end
    KbQueueRelease(Serial);
end
%%

ListenChar(2)
disp('Phase 1')

pop=figure('position',[492   455   862   270],...
    'menubar','none','numbertitle','off','resize','off');
text(.4,.5,'Wait','fontsize',30); axis off
text(0,.3,'Hit ENTER when okay to start next','fontsize',30)
yesKeys = KbName('Return');
pause(5)
while true
    [~,~,keyCode] = KbCheck;
    	if any(keyCode(yesKeys))
            break
        end
end;
close(pop)
disp('Phase 2')

%%
