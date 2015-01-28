function setConditionsForNeuronBrowser(handles)
%setConditionsForNeuronBrowser.m Opens GUI and sets conditions for the
%neuron browser 3000
%
%INPUTS
%handles - structure of handles
%
%ASM 11/13

%get current conditions
origConditions = get(handles.setConditions,'UserData');

%launch gui
setConditionsGUI(origConditions,handles);