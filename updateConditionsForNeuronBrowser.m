function updateConditionsForNeuronBrowser(handles,hObject)
%updateConditionsForNeuronBrowser.m Callback for all edit boxes in set
%conditions window
%
%INPUTS
%handles - structure of handles
%
%ASM 11/13

%initialize
condInfo.ranges = cell(1,16);
condInfo.conditions = cell(1,16);
condInfo.checks = zeros(1,16);

%cycle through each condition and store info
for i = 1:16
    
    rangeName = sprintf('range%d',i); %generate range name (range1, range2, etc.)
    condName = sprintf('cond%d',i); %generate cond name (cond1, cond2, etc.)
    checkName = sprintf('checkbox%d',i); %generate checkbox name (checkbox1, checkbox2, etc.)
    
    condInfo.checks(i) = get(handles.(checkName),'Value');
    condInfo.ranges{i} = get(handles.(rangeName),'String'); %update range string
    condInfo.conditions{i} = get(handles.(condName),'String'); %update cond string
end

%determine calling object
fields = fieldnames(handles);
for i = 1:length(fields)
    fieldVal = handles.(fields{i});
    if ~isnumeric(fieldVal)
        continue;
    end
    if fieldVal == hObject
        callingName = fields{i};
        if strfind(callingName,'checkbox') %if called by checkbox being uncheckd
            break;
        end
        checkNum = str2double(regexp(callingName,'\d*','match'));
        checkName = sprintf('checkbox%d',checkNum);
        set(handles.(checkName),'Value',1);
        condInfo.checks(checkNum) = 1;
        break;
    end
end

%convert cells with 'Enter Condition' to empty
condInfo.conditions(cell2mat(cellfun(@(x) strcmp(x,'Enter Condition'),condInfo.conditions,'UniformOutput',false))) = {''};

%remove unchecked cells
condInfo.ranges(condInfo.checks ~= 1) = '';
condInfo.conditions(condInfo.checks ~= 1) = '';

%store in setConditions userdata
set(handles.browserHandles.setConditions,'UserData',condInfo);

%update plot
plotNeuronBrowserData(handles.browserHandles)