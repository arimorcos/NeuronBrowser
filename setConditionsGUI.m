function varargout = setConditionsGUI(varargin)
% SETCONDITIONSGUI MATLAB code for setConditionsGUI.fig
%      SETCONDITIONSGUI, by itself, creates a new SETCONDITIONSGUI or raises the existing
%      singleton*.
%
%      H = SETCONDITIONSGUI returns the handle to a new SETCONDITIONSGUI or the handle to
%      the existing singleton*.
%
%      SETCONDITIONSGUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SETCONDITIONSGUI.M with the given input arguments.
%
%      SETCONDITIONSGUI('Property','Value',...) creates a new SETCONDITIONSGUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before setConditionsGUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to setConditionsGUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help setConditionsGUI

% Last Modified by GUIDE v2.5 21-Nov-2013 18:50:19

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @setConditionsGUI_OpeningFcn, ...
                   'gui_OutputFcn',  @setConditionsGUI_OutputFcn, ...
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


% --- Executes just before setConditionsGUI is made visible.
function setConditionsGUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to setConditionsGUI (see VARARGIN)

% Choose default command line output for setConditionsGUI
handles.output = hObject;



%update conditions
condInfo = varargin{1}; %get condInfo
nConds = length(condInfo.ranges); %get number of conds

for i = 1:16
    if i > nConds %if past designated conditions
        break; %break out of loop
    end
    
    rangeName = sprintf('range%d',i); %generate range name (range1, range2, etc.)
    condName = sprintf('cond%d',i); %generate cond name (cond1, cond2, etc.)
    checkName = sprintf('checkbox%d',i); %generate checkbox name (checkbox1, checkbox2, etc.)
    set(handles.(rangeName),'String',condInfo.ranges{i}); %update range string
    set(handles.(condName),'String',condInfo.conditions{i}); %update cond string
    set(handles.(checkName),'Value',condInfo.checks(i));
end

handles.browserHandles = varargin{2};

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes setConditionsGUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = setConditionsGUI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function range1_Callback(hObject, eventdata, handles)
% hObject    handle to range1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of range1 as text
%        str2double(get(hObject,'String')) returns contents of range1 as a double

updateConditionsForNeuronBrowser(handles,hObject);


% --- Executes during object creation, after setting all properties.
function range1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to range1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function cond1_Callback(hObject, eventdata, handles)
% hObject    handle to cond1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of cond1 as text
%        str2double(get(hObject,'String')) returns contents of cond1 as a double

updateConditionsForNeuronBrowser(handles,hObject);


% --- Executes during object creation, after setting all properties.
function cond1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to cond1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function range3_Callback(hObject, eventdata, handles)
% hObject    handle to range3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of range3 as text
%        str2double(get(hObject,'String')) returns contents of range3 as a double

updateConditionsForNeuronBrowser(handles,hObject);


% --- Executes during object creation, after setting all properties.
function range3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to range3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function cond3_Callback(hObject, eventdata, handles)
% hObject    handle to cond3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of cond3 as text
%        str2double(get(hObject,'String')) returns contents of cond3 as a double

updateConditionsForNeuronBrowser(handles,hObject);


% --- Executes during object creation, after setting all properties.
function cond3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to cond3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function range4_Callback(hObject, eventdata, handles)
% hObject    handle to range4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of range4 as text
%        str2double(get(hObject,'String')) returns contents of range4 as a double

updateConditionsForNeuronBrowser(handles,hObject);


% --- Executes during object creation, after setting all properties.
function range4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to range4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function cond6_Callback(hObject, eventdata, handles)
% hObject    handle to cond6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of cond6 as text
%        str2double(get(hObject,'String')) returns contents of cond6 as a double

updateConditionsForNeuronBrowser(handles,hObject);


% --- Executes during object creation, after setting all properties.
function cond6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to cond6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function range7_Callback(hObject, eventdata, handles)
% hObject    handle to range7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of range7 as text
%        str2double(get(hObject,'String')) returns contents of range7 as a double

updateConditionsForNeuronBrowser(handles,hObject);


% --- Executes during object creation, after setting all properties.
function range7_CreateFcn(hObject, eventdata, handles)
% hObject    handle to range7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function cond9_Callback(hObject, eventdata, handles)
% hObject    handle to cond9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of cond9 as text
%        str2double(get(hObject,'String')) returns contents of cond9 as a double

updateConditionsForNeuronBrowser(handles,hObject);


% --- Executes during object creation, after setting all properties.
function cond9_CreateFcn(hObject, eventdata, handles)
% hObject    handle to cond9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function range15_Callback(hObject, eventdata, handles)
% hObject    handle to range15 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of range15 as text
%        str2double(get(hObject,'String')) returns contents of range15 as a double

updateConditionsForNeuronBrowser(handles,hObject);

% --- Executes during object creation, after setting all properties.
function range15_CreateFcn(hObject, eventdata, handles)
% hObject    handle to range15 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function cond15_Callback(hObject, eventdata, handles)
% hObject    handle to cond15 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of cond15 as text
%        str2double(get(hObject,'String')) returns contents of cond15 as a double

updateConditionsForNeuronBrowser(handles,hObject);


% --- Executes during object creation, after setting all properties.
function cond15_CreateFcn(hObject, eventdata, handles)
% hObject    handle to cond15 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function range16_Callback(hObject, eventdata, handles)
% hObject    handle to range16 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of range16 as text
%        str2double(get(hObject,'String')) returns contents of range16 as a double

updateConditionsForNeuronBrowser(handles,hObject);

% --- Executes during object creation, after setting all properties.
function range16_CreateFcn(hObject, eventdata, handles)
% hObject    handle to range16 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function cond16_Callback(hObject, eventdata, handles)
% hObject    handle to cond16 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of cond16 as text
%        str2double(get(hObject,'String')) returns contents of cond16 as a double

updateConditionsForNeuronBrowser(handles,hObject);

% --- Executes during object creation, after setting all properties.
function cond16_CreateFcn(hObject, eventdata, handles)
% hObject    handle to cond16 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function range2_Callback(hObject, eventdata, handles)
% hObject    handle to range2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of range2 as text
%        str2double(get(hObject,'String')) returns contents of range2 as a double

updateConditionsForNeuronBrowser(handles,hObject);

% --- Executes during object creation, after setting all properties.
function range2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to range2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function cond2_Callback(hObject, eventdata, handles)
% hObject    handle to cond2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of cond2 as text
%        str2double(get(hObject,'String')) returns contents of cond2 as a double

updateConditionsForNeuronBrowser(handles,hObject);

% --- Executes during object creation, after setting all properties.
function cond2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to cond2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function cond7_Callback(hObject, eventdata, handles)
% hObject    handle to cond7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of cond7 as text
%        str2double(get(hObject,'String')) returns contents of cond7 as a double

updateConditionsForNeuronBrowser(handles,hObject);

% --- Executes during object creation, after setting all properties.
function cond7_CreateFcn(hObject, eventdata, handles)
% hObject    handle to cond7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function cond8_Callback(hObject, eventdata, handles)
% hObject    handle to cond8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of cond8 as text
%        str2double(get(hObject,'String')) returns contents of cond8 as a double

updateConditionsForNeuronBrowser(handles,hObject);

% --- Executes during object creation, after setting all properties.
function cond8_CreateFcn(hObject, eventdata, handles)
% hObject    handle to cond8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function cond4_Callback(hObject, eventdata, handles)
% hObject    handle to cond4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of cond4 as text
%        str2double(get(hObject,'String')) returns contents of cond4 as a double

updateConditionsForNeuronBrowser(handles,hObject);

% --- Executes during object creation, after setting all properties.
function cond4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to cond4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function cond5_Callback(hObject, eventdata, handles)
% hObject    handle to cond5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of cond5 as text
%        str2double(get(hObject,'String')) returns contents of cond5 as a double

updateConditionsForNeuronBrowser(handles,hObject);

% --- Executes during object creation, after setting all properties.
function cond5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to cond5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function cond10_Callback(hObject, eventdata, handles)
% hObject    handle to cond10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of cond10 as text
%        str2double(get(hObject,'String')) returns contents of cond10 as a double

updateConditionsForNeuronBrowser(handles,hObject);

% --- Executes during object creation, after setting all properties.
function cond10_CreateFcn(hObject, eventdata, handles)
% hObject    handle to cond10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function cond11_Callback(hObject, eventdata, handles)
% hObject    handle to cond11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of cond11 as text
%        str2double(get(hObject,'String')) returns contents of cond11 as a double

updateConditionsForNeuronBrowser(handles,hObject);

% --- Executes during object creation, after setting all properties.
function cond11_CreateFcn(hObject, eventdata, handles)
% hObject    handle to cond11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function cond12_Callback(hObject, eventdata, handles)
% hObject    handle to cond12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of cond12 as text
%        str2double(get(hObject,'String')) returns contents of cond12 as a double

updateConditionsForNeuronBrowser(handles,hObject);

% --- Executes during object creation, after setting all properties.
function cond12_CreateFcn(hObject, eventdata, handles)
% hObject    handle to cond12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function cond13_Callback(hObject, eventdata, handles)
% hObject    handle to cond13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of cond13 as text
%        str2double(get(hObject,'String')) returns contents of cond13 as a double

updateConditionsForNeuronBrowser(handles,hObject);

% --- Executes during object creation, after setting all properties.
function cond13_CreateFcn(hObject, eventdata, handles)
% hObject    handle to cond13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function cond14_Callback(hObject, eventdata, handles)
% hObject    handle to cond14 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of cond14 as text
%        str2double(get(hObject,'String')) returns contents of cond14 as a double

updateConditionsForNeuronBrowser(handles,hObject);

% --- Executes during object creation, after setting all properties.
function cond14_CreateFcn(hObject, eventdata, handles)
% hObject    handle to cond14 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function range8_Callback(hObject, eventdata, handles)
% hObject    handle to range8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of range8 as text
%        str2double(get(hObject,'String')) returns contents of range8 as a double

updateConditionsForNeuronBrowser(handles,hObject);

% --- Executes during object creation, after setting all properties.
function range8_CreateFcn(hObject, eventdata, handles)
% hObject    handle to range8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function range5_Callback(hObject, eventdata, handles)
% hObject    handle to range5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of range5 as text
%        str2double(get(hObject,'String')) returns contents of range5 as a double

updateConditionsForNeuronBrowser(handles,hObject);

% --- Executes during object creation, after setting all properties.
function range5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to range5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function range6_Callback(hObject, eventdata, handles)
% hObject    handle to range6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of range6 as text
%        str2double(get(hObject,'String')) returns contents of range6 as a double

updateConditionsForNeuronBrowser(handles,hObject);

% --- Executes during object creation, after setting all properties.
function range6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to range6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function range11_Callback(hObject, eventdata, handles)
% hObject    handle to range11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of range11 as text
%        str2double(get(hObject,'String')) returns contents of range11 as a double

updateConditionsForNeuronBrowser(handles,hObject);

% --- Executes during object creation, after setting all properties.
function range11_CreateFcn(hObject, eventdata, handles)
% hObject    handle to range11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function range12_Callback(hObject, eventdata, handles)
% hObject    handle to range12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of range12 as text
%        str2double(get(hObject,'String')) returns contents of range12 as a double

updateConditionsForNeuronBrowser(handles,hObject);

% --- Executes during object creation, after setting all properties.
function range12_CreateFcn(hObject, eventdata, handles)
% hObject    handle to range12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function range13_Callback(hObject, eventdata, handles)
% hObject    handle to range13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of range13 as text
%        str2double(get(hObject,'String')) returns contents of range13 as a double

updateConditionsForNeuronBrowser(handles,hObject);

% --- Executes during object creation, after setting all properties.
function range13_CreateFcn(hObject, eventdata, handles)
% hObject    handle to range13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function range14_Callback(hObject, eventdata, handles)
% hObject    handle to range14 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of range14 as text
%        str2double(get(hObject,'String')) returns contents of range14 as a double

updateConditionsForNeuronBrowser(handles,hObject);

% --- Executes during object creation, after setting all properties.
function range14_CreateFcn(hObject, eventdata, handles)
% hObject    handle to range14 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function range9_Callback(hObject, eventdata, handles)
% hObject    handle to range9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of range9 as text
%        str2double(get(hObject,'String')) returns contents of range9 as a double

updateConditionsForNeuronBrowser(handles,hObject);

% --- Executes during object creation, after setting all properties.
function range9_CreateFcn(hObject, eventdata, handles)
% hObject    handle to range9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function range10_Callback(hObject, eventdata, handles)
% hObject    handle to range10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of range10 as text
%        str2double(get(hObject,'String')) returns contents of range10 as a double

updateConditionsForNeuronBrowser(handles,hObject);

% --- Executes during object creation, after setting all properties.
function range10_CreateFcn(hObject, eventdata, handles)
% hObject    handle to range10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in checkbox1.
function checkbox1_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox1
updateConditionsForNeuronBrowser(handles,hObject);

% --- Executes on button press in checkbox2.
function checkbox2_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox2
updateConditionsForNeuronBrowser(handles,hObject);

% --- Executes on button press in checkbox3.
function checkbox3_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox3
updateConditionsForNeuronBrowser(handles,hObject);

% --- Executes on button press in checkbox4.
function checkbox4_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox4
updateConditionsForNeuronBrowser(handles,hObject);

% --- Executes on button press in checkbox5.
function checkbox5_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox5
updateConditionsForNeuronBrowser(handles,hObject);

% --- Executes on button press in checkbox6.
function checkbox6_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox6
updateConditionsForNeuronBrowser(handles,hObject);

% --- Executes on button press in checkbox7.
function checkbox7_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox7
updateConditionsForNeuronBrowser(handles,hObject);

% --- Executes on button press in checkbox8.
function checkbox8_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox8
updateConditionsForNeuronBrowser(handles,hObject);

% --- Executes on button press in checkbox9.
function checkbox9_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox9
updateConditionsForNeuronBrowser(handles,hObject);

% --- Executes on button press in checkbox10.
function checkbox10_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox10
updateConditionsForNeuronBrowser(handles,hObject);

% --- Executes on button press in checkbox11.
function checkbox11_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox11
updateConditionsForNeuronBrowser(handles,hObject);

% --- Executes on button press in checkbox12.
function checkbox12_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox12
updateConditionsForNeuronBrowser(handles,hObject);

% --- Executes on button press in checkbox13.
function checkbox13_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox13
updateConditionsForNeuronBrowser(handles,hObject);

% --- Executes on button press in checkbox14.
function checkbox14_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox14 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox14
updateConditionsForNeuronBrowser(handles,hObject);

% --- Executes on button press in checkbox15.
function checkbox15_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox15 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox15
updateConditionsForNeuronBrowser(handles,hObject);

% --- Executes on button press in checkbox16.
function checkbox16_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox16 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox16
updateConditionsForNeuronBrowser(handles,hObject);