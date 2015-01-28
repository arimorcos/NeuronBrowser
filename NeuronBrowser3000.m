function varargout = NeuronBrowser3000(varargin)
% NEURONBROWSER3000 MATLAB code for NeuronBrowser3000.fig
%      NEURONBROWSER3000, by itself, creates a new NEURONBROWSER3000 or raises the existing
%      singleton*.
%
%      H = NEURONBROWSER3000 returns the handle to a new NEURONBROWSER3000 or the handle to
%      the existing singleton*.
%
%      NEURONBROWSER3000('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in NEURONBROWSER3000.M with the given input arguments.
%
%      NEURONBROWSER3000('Property','Value',...) creates a new NEURONBROWSER3000 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before NeuronBrowser3000_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to NeuronBrowser3000_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help NeuronBrowser3000

% Last Modified by GUIDE v2.5 26-Nov-2013 13:12:48

% Begin initialization code - DO NOT EDIT
gui_Singleton = 0;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @NeuronBrowser3000_OpeningFcn, ...
                   'gui_OutputFcn',  @NeuronBrowser3000_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before NeuronBrowser3000 is made visible.
function NeuronBrowser3000_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to NeuronBrowser3000 (see VARARGIN)

% Choose default command line output for NeuronBrowser3000
handles.output = hObject;

%process varargin 
if ischar(varargin{1})
    for argInd = 1:2:length(varargin)
        switch lower(varargin{argInd})
            case 'cellfile'
                fileName = varargin{argInd+1};
                load(fileName,'dataCell');
                [~,name] = fileparts(fileName);
            otherwise
                error(sprintf('Cannot interpret %s',varargin{1}));
        end
    end
elseif iscell(varargin{1})
    dataCell = varargin{1};
    name = sprintf('%s%d_%s',dataCell{1}.info.experimenter,dataCell{1}.info.mouse,dataCell{1}.info.date);
end

%get cellfile if not provided
if ~exist('dataCell','var')
    baseDir = 'D:\Data\Ari';
    origDir = cd(baseDir);
    [name,path] = uigetfile('*Cell*.mat');
    cd(origDir);
    fileName = fullfile(path,name); %get filename
    load(fileName,'dataCell'); %load in dataCell
end      

%set initial conditions
% condInfo.conditions = {'',...
%                     'maze.crutchTrial == 0',...
%               'maze.crutchTrial == 1',...
%               'result.leftTurn == 1',...
%               'result.leftTurn == 0',...
%               'maze.crutchTrial == 0;result.leftTurn == 0',...
%               'maze.crutchTrial == 0;result.leftTurn == 1',...
%               'maze.crutchTrial == 1;result.leftTurn == 0',...
%               'maze.crutchTrial == 1;result.leftTurn == 1',...
%               'maze.crutchTrial == 0;result.correct == 1',...
%               'maze.crutchTrial == 0;result.correct == 0',...
%               'maze.crutchTrial == 1;result.correct == 1',...
%               'maze.crutchTrial == 1;result.correct == 0'};
% condInfo.ranges = {':',...
%                    ':',...
%                    ':',...
%                    ':',...
%                    ':',...
%                    ':',...
%                    ':',...
%                    ':',...
%                    ':',...
%                    ':',...
%                    ':',...
%                    ':',...
%                    ':'};
% condInfo.conditions = {'maze.crutchTrial == 0;maze.numLeft == 0;result.correct==1',...
%                        'maze.crutchTrial == 0;maze.numLeft == 1;result.correct==1',...
%                        'maze.crutchTrial == 0;maze.numLeft == 2;result.correct==1',...
%                        'maze.crutchTrial == 0;maze.numLeft == 3;result.correct==1',...
%                        'maze.crutchTrial == 0;maze.numLeft == 4;result.correct==1',...
%                        'maze.crutchTrial == 0;maze.numLeft == 5;result.correct==1',...
%                        'maze.crutchTrial == 0;maze.numLeft == 6;result.correct==1',...
%                        'maze.crutchTrial == 0;maze.numLeft == 0,1;result.correct==1',...
%                        'maze.crutchTrial == 0;maze.numLeft == 5,6;result.correct==1'};
% condInfo.ranges = {':',...
%                    ':',...
%                    ':',...
%                    ':',...
%                    ':',...
%                    ':',...
%                    ':',...
%                    ':',...
%                    ':'};
% condInfo.conditions = {'maze.crutchTrial == 0;maze.numLeft == 0;result.correct==1',...
%                        'maze.crutchTrial == 0;maze.numLeft == 1;result.correct==1',...
%                        'maze.crutchTrial == 0;maze.numLeft == 5;result.correct==1',...
%                        'maze.crutchTrial == 0;maze.numLeft == 6;result.correct==1',...
%                        'maze.crutchTrial == 0;maze.numLeft == 0,1;result.correct==1',...
%                        'maze.crutchTrial == 0;maze.numLeft == 5,6;result.correct==1'};
% condInfo.ranges = {':',...
%                    ':',...
%                    ':',...
%                    ':',...
%                    ':',...
%                    ':'};
condInfo.conditions = {'netEv==4,-4',...
                       'netEv==4,-2',...
                       'netEv==4,0',...
                       'netEv==4,2',...
                       'netEv==4,4'};
condInfo.ranges = {':',...
                   ':',...
                   ':',...
                   ':',...
                   ':'};
condInfo.checks = zeros(1,16);
condInfo.checks(1:length(condInfo.ranges)) = 1;
set(handles.setConditions,'UserData',condInfo);

%create default subsets
subsets.options = {'No Subset';...
                   'maze.crutchTrial==0;result.correct==1;result.leftTurn==1 _>_ maze.crutchTrial==0;result.correct==1;result.leftTurn==0';...
                   'maze.crutchTrial==0;result.correct==1;result.leftTurn==1 _<_ maze.crutchTrial==0;result.correct==1;result.leftTurn==0';... 
                   'maze.crutchTrial==0;result.correct==0;result.leftTurn==1 _>_ maze.crutchTrial==0;result.correct==0;result.leftTurn==0';... 
                   'maze.crutchTrial==0;result.correct==0;result.leftTurn==1 _<_ maze.crutchTrial==0;result.correct==0;result.leftTurn==0'};
set(handles.subsetSignificance,'UserData',subsets);

%load in data array
if ~isfield(dataCell{1},'dat') %if doesn't contain dat field
    matName = regexp(fileName,'_Cell','split');
    matName = [matName{:}];
    load(matName,'data'); %load data
    dataCell = parseDataArray(dataCell,data);
    save(fileName,'dataCell'); %resave
end

%check if imaging data
if ~isfield(dataCell{1},'imaging') || sum(findTrials(dataCell,'imaging.imData == 1')) == 0
    fprintf('No imaging data contained in %s\n',name);
    delete(hObject);
    return;
end

%thresh
% dataCell = threshDataCell(dataCell);
% dataCell = softThreshDataCell(dataCell);

%bin frames
if ~isfield(dataCell{1}.imaging,'binnedDGRTraces');
    imData.binSize = 5;
    dataCell = binFramesByYPos(dataCell,imData.binSize);
end

%convert to individual neurons
[actByNeuron,imTrials] = convertBinnedByTrialToByNeuron(dataCell);

%store in imData array
imData.dataCell = dataCell;
imData.actByNeuron = actByNeuron;
imData.imTrials = imTrials;

%update planeSelect listbox
imData.planeIDs = find(cell2mat(cellfun(@(x) ~isempty(x),dataCell{imTrials(1)}.imaging.binnedDGRTraces,...
    'UniformOutput',false))==1);
set(handles.planeSelect,'String',cellfun(@(x) num2str(x),num2cell(imData.planeIDs),...
    'UniformOutput',false));

%store neuron array
imData.defaultNeuronList = 1:size(actByNeuron{min(imData.planeIDs)},2);
imData.currNeuronList = imData.defaultNeuronList;

%store in figure
set(handles.neuronNum,'UserData',imData);

%update name
set(hObject,'Name',sprintf('Neuron Browser 3000: %s',name));
imData.defaultTitle = sprintf('Neuron Browser 3000: %s',name);

%store figure handle in handles
handles.figure = hObject;

%initalize options
options.confidenceInterval = 95;
options.showConfidenceInterval = false;
options.divisionSpacing = [0.25 0.75];
options.excludeTurnAroundTrials = true;
options.subsetPValue = 0.05;
options.subsetPercBins = 10;

%store options
set(handles.optionsButton,'UserData',options);

%update plots
neuronNum_Callback(handles.neuronNum, eventdata, handles)

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes NeuronBrowser3000 wait for user response (see UIRESUME)
% uiwait(handles.planeText);


% --- Outputs from this function are returned to the command line.
function varargout = NeuronBrowser3000_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
% varargout{1} = handles.output;


% --- Executes on button press in LeftBrowse.
function LeftBrowse_Callback(hObject, eventdata, handles)
% hObject    handle to LeftBrowse (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

currNeuron = str2double(get(handles.neuronNum,'String'));
imData = get(handles.neuronNum,'UserData');
currInd = find(imData.currNeuronList == currNeuron);
if currInd > 1
    newNeuron = imData.currNeuronList(currInd - 1);
else
    newNeuron = currNeuron;
end
set(handles.neuronNum,'String',num2str(newNeuron));
neuronNum_Callback(handles.neuronNum, eventdata, handles)


% --- Executes on button press in rightBrowse.
function rightBrowse_Callback(hObject, eventdata, handles)
% hObject    handle to rightBrowse (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

currNeuron = str2double(get(handles.neuronNum,'String'));
imData = get(handles.neuronNum,'UserData');
currInd = find(imData.currNeuronList == currNeuron);
if currInd < length(imData.currNeuronList)
    newNeuron = imData.currNeuronList(currInd + 1);
else
    newNeuron = currNeuron;
end
set(handles.neuronNum,'String',num2str(newNeuron));
neuronNum_Callback(handles.neuronNum, eventdata, handles)


function neuronNum_Callback(hObject, eventdata, handles)
% hObject    handle to neuronNum (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of neuronNum as text
%        str2double(get(hObject,'String')) returns contents of neuronNum as a double
plotNeuronBrowserData(handles)

% --- Executes during object creation, after setting all properties.
function neuronNum_CreateFcn(hObject, eventdata, handles)
% hObject    handle to neuronNum (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in export.
function export_Callback(hObject, eventdata, handles)
% hObject    handle to export (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

exportNeuronBrowserData(handles);


% --- Executes on button press in setConditions.
function setConditions_Callback(hObject, eventdata, handles)
% hObject    handle to setConditions (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

setConditionsForNeuronBrowser(handles)


% --- Executes on selection change in planeSelect.
function planeSelect_Callback(hObject, eventdata, handles)
% hObject    handle to planeSelect (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns planeSelect contents as cell array
%        contents{get(hObject,'Value')} returns selected item from planeSelect

%get imData
imData = get(handles.neuronNum,'UserData');

%create new neuron lists
options = str2double(get(hObject,'String'));
imData.defaultNeuronList = 1:size(imData.actByNeuron{min(...
    options(get(hObject,'Value')))},2);
imData.currNeuronList = imData.defaultNeuronList;

%store updated imData
set(handles.neuronNum,'UserData',imData);

%set to first value
set(handles.neuronNum,'String',num2str(imData.currNeuronList(1)));

%update plot, etc.
neuronNum_Callback(handles.neuronNum, eventdata, handles);



% --- Executes during object creation, after setting all properties.
function planeSelect_CreateFcn(hObject, eventdata, handles)
% hObject    handle to planeSelect (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in rawTraces.
function rawTraces_Callback(hObject, eventdata, handles)
% hObject    handle to rawTraces (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%open raw traces window
plotRawTracesForNeuronBrowser(handles);


% --------------------------------------------------------------------
function optionsButton_ClickedCallback(hObject, eventdata, handles)
% hObject    handle to optionsButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
editOptions_CALLBACK(handles);


% --------------------------------------------------------------------
function subsetSignificance_ClickedCallback(hObject, eventdata, handles)
% hObject    handle to subsetSignificance (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

subsetNeuronBrowser(handles);
