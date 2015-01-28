function exportNeuronBrowserData(handles)
%exportNeuronBrowserData.m Function to export data from neuron browser.
%Launches message box to ask which neurons to export and exports to pdf,
%eps, etc.
%
%INPUTS
%handles - handles structure
%
%ASM 11/13

%get imData
imData = get(handles.neuronNum,'UserData');

%get current neuron number
neuronNum = str2double(get(handles.neuronNum,'String'));

%get nNeurons 
% nNeurons = size(imData.dataCell{1}.imaging.completeDFFTrace,1);

%find out which neurons to export
whichNeurons = inputdlg('Which neurons would you like to export? Input range as min:max',...
    'Export neurons',1,{num2str(neuronNum)});

%extract string
whichNeurons = whichNeurons{1};

%parse string
if strfind(whichNeurons,':') %if it contains a colon
    minVal = str2double(regexp(whichNeurons,'\d*(?=:\d*)','match'));
    maxVal = str2double(regexp(whichNeurons,'(?<=\d*:)\d*','match'));
elseif all(isstrprop(whichNeurons,'digit')) %if all are digits
    minVal = str2double(whichNeurons);
    maxVal = str2double(whichNeurons);
else
    errordlg('Unrecognized string');
end

%get nExport
nExport = maxVal - minVal + 1;

%ask where to save file
if nExport == 1 %if only one neuron
    [filename,pathname] = uiputfile({'*.pdf','PDF File (*.pdf)';...
        '*.eps','EPS (*.eps)';'*.jpg','JPEG Image(*.jpg)';...
        '*.fig','MATLAB Figure (*.fig)';'*.png','PNG Image (*.png)';...
        '*.tif','TIFF Image (*.tif)';});
else %if multiple files, only allow pdf
    [filename,pathname] = uiputfile({'*.pdf','PDF File (*.pdf)'});
end

if filename == 0 %if canceled
    return;
end

%create waitbar
hWait = waitbar(0,sprintf('Exporting neuron %d/%d',0,nExport));

%export
for i = minVal:maxVal %for each value
    
    %update waitbar
    waitbar((i+1-minVal)/nExport,hWait,sprintf('Exporting neuron %d/%d',i+1-minVal,nExport));
    
    %create figure and make invisible
    saveFig = figure('Visible','Off');
    
    %maximize figure
    set(saveFig,'Units','Normalized','OuterPosition',[0 0 1 1],'PaperPositionMode','auto');
    
    %plot data
    plotNeuronBrowserData(handles,true,i);
    
    if minVal == maxVal
        switch upper(filename(find(filename=='.',1,'last')+1:end))
            case 'EPS'
                export_fig(saveFig,[pathname,filename],'-eps');
            case 'JPG'
                export_fig(saveFig,[pathname,filename],'-jpg','-transparent');
            case 'FIG'
                saveas(saveFig,[pathname,filename],'-loose','-r300');
            case 'PNG'
                export_fig(saveFig,[pathname,filename],'-png','-transparent');
            case 'TIF'
                export_fig(saveFig,[pathname,filename],'-tif','-transparent');
            case 'PDF'
                export_fig(saveFig,[pathname,filename],'-pdf','-opengl');
        end
    else
        export_fig(saveFig,[pathname,filename],'-pdf','-append','-opengl');
    end
    
    %close save fig
    delete(saveFig);
end

%close waitbar
delete(hWait);
