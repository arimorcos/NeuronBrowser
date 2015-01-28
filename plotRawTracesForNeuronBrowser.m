function plotRawTracesForNeuronBrowser(handles)
%plotRawTracesForNeuronBrowser.m Function to plot raw traces vs. time for a
%given neuron 
%
%INPUTS
%handles - structure of handles
%
%ASM 11/13

%get imData
imData = get(handles.neuronNum,'UserData');

%get raw traces data
rawTraces = imData.dataCell{1}.imaging.completeDFFTrace;

%get neuron number
neuronNum = str2double(get(handles.neuronNum,'String'));

%create new figure
figure('Name',sprintf('Neuron Browser 3000: Raw Trace for neuron %d',neuronNum));

%plot raw trace
plot(rawTraces(neuronNum,:),'k');

%xlabel
xlabel('Frame #','FontSize',25,'FontWeight','Bold');

%ylabel
ylabel('dF/F','FontSize',25,'FontWeight','Bold');

%title
title(sprintf('dF/F for neuron %d',neuronNum),'FontWeight','Bold',...
    'FontSize',25);
