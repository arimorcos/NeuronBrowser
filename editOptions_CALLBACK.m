function editOptions_CALLBACK(handles)
%editOptions_CALLBACK.m function to edit the options structure
%
%INPUTS
%handles - handles structure 
%
%ASM 11/13

%get options
options = get(handles.optionsButton,'UserData');

%create figure
figH = figure('Name','Modify Options','NumberTitle','off','MenuBar','none');

%get figure position
currPos = get(figH,'OuterPosition');

%figure out how many fields in options
fields = fieldnames(options);
nFields = length(fields);

%update figure position
set(figH,'OuterPosition',[currPos(1) currPos(2) 750 nFields*60]);

%create table
tableData = cell(nFields,2);
for i = 1:nFields
    tableData{i,1} = fields{i};
    tableData{i,2} = num2str(options.(fields{i}));
end

%put table in figure
tableH = uitable('Data',tableData,'Units','Normalized','Position',[0 0 1 1],...
    'ColumnWidth',{400 300},'ColumnName',{'Variable','Value'},...
    'ColumnEditable',[false,true],'FontSize',20);
set(tableH,'CellEditCallback',{@editOptionsCell,handles,tableH});


function editOptionsCell(src,evnt,handles,tableH)

%get table data and store in options array
tableData = get(tableH,'Data'); %get table data
nFields = size(tableData,1); % get nFields

for i = 1:nFields %for each field
    fieldVal = str2num(tableData{i,2});
    options.(tableData{i,1}) = fieldVal;
end

%store in options
set(handles.optionsButton,'UserData',options);

%update plots
plotNeuronBrowserData(handles);

