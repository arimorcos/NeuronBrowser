function subsetNeuronBrowser(handles)
%subsetNeuronBrowser.m Subsets neruon based on significant differences
%between conditions
%
%INPUTS
%handles - handles structure
%
%ASM 11/13

%open up figure with list of subsets
subsetFig = figure('Name','Subsets','MenuBar','none','NumberTitle','off');

%get current subsets
subsets = get(handles.subsetSignificance,'UserData');

%get figure position
currPos = get(subsetFig,'OuterPosition');

%ensure last field of subsets is empty
if ~isempty(subsets.options{end})
    subsets.options{length(subsets.options)+1} = '';
end

%figure out how many subsets
nSubsets = length(subsets.options);

%update figure position
set(subsetFig,'OuterPosition',[currPos(1) currPos(2) 1550 (nSubsets+1)*60]);

%create uitable
subsetTable = uitable('Data',subsets.options,'Units','Normalized','Position',...
    [0 0.05 1 0.95],'ColumnWidth',{1500},'ColumnName',{'Subsets'},'ColumnEditable',...
    false,'FontSize',15);
set(subsetTable,'CellSelectionCallback',{@confirmSubset,handles,subsetTable,...
    subsets});

%create edit button
editButton = uicontrol('style','togglebutton','Units','Normalized','Position',...
    [0 0.01 1 0.04],'String','Edit Subsets','Callback',{@editSubsets,subsetTable,...
    handles,subsetFig,subsets});

%set celledit callback
set(subsetTable,'CellEditCallback',{@addSubsetRow,subsetTable});

function confirmSubset(src,evnt,handles,subsetTable,subsets)

%get new subsets
subsets.options = get(subsetTable,'Data');

%store new subsets
set(handles.subsetSignificance,'UserData',subsets);

%get selected condition
selectedSub = subsets.options{evnt.Indices(1)};

%get imData
imData = get(handles.neuronNum,'UserData');

%check if no subset
if strcmp(selectedSub,'No Subset')
    imData.currNeuronList = imData.defaultNeuronList;
else

    %parse condition string 
    parsedSub = parseSubsetNeuronBrowser(selectedSub);

    %check if empty (error thrown)
    if isempty(parsedSub)
        return;
    end

    %find significant subset differences
    sigNeurons = findSignificantSubsetDiff(handles,parsedSub);
    
    %check if any significant values
    if isempty(sigNeurons)
        msgbox('No significant neurons found');
        return;
    end
    
    %update current neuron list
    imData.currNeuronList = sigNeurons;
    
end

%update title
newTitle = sprintf('%s    SUBSET: %s',imData.defaultTitle,selectedSub);
set(handles.figure,'Name',newTitle);

%set current neuron to first neuron in curr Neuron list
set(handles.neuronNum,'String',num2str(imData.currNeuronList(1)));
plotNeuronBrowserData(handles);



%store updated imData
set(handles.neuronNum,'UserData',imData);

function editSubsets(src,evnt,subsetTable,handles,subsetFig,subsets)

%get current value
if get(gcbo,'Value') %if currently in edit mode
    
    %update string
    set(gcbo,'String','End Editing');
    
    %remove callback
    set(subsetTable,'CellSelectionCallback',{});
    
    %make editable
    set(subsetTable,'ColumnEditable',true);
    
else
    
    %update string
    set(gcbo,'String','Edit Subsets');
    
    %re-add callback
    set(subsetTable,'CellSelectionCallback',{@confirmSubset,handles,subsetTable,...
        subsets});
    
    %make not editable
    set(subsetTable,'ColumnEditable',false);
end

function addSubsetRow(src,evnt,subsetTable)

%get subsets
subsets.options = get(subsetTable,'Data');

%find any empty fields in subsets 1:end-1 
subsets.options = subsets.options(cell2mat(cellfun(@(x) ~isempty(x),...
    subsets.options,'UniformOutput',false)));

%get nSubsets
nSubsets = length(subsets.options);

%ensure last field of subsets is empty
if ~isempty(subsets.options{end})
    subsets.options{nSubsets+1} = '';
end



%update table
set(subsetTable,'Data',subsets.options);