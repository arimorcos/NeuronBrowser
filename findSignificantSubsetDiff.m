function sigNeurons = findSignificantSubsetDiff(handles,parsedSub)
%findSignificantSubsetDiff.m Function which analyzes the conditions in
%parsed sub to find neurons which are significantly different between the
%two subsets using parameters specified in options
%
%INPUTS
%handles - handles structure
%parsedSub - parsed subset generated by parseSubsetNeuronBrowser
%
%OUTPUTS
%sigNeurons - nSigNeurons x 1 array containing neuronIDs of each
%   significant neuron
%
%ASM 11/13

%get options
options = get(handles.optionsButton,'UserData');

%get imData
imData = get(handles.neuronNum,'UserData');

%get imSub
imSub = imData.dataCell(imData.imTrials);

%get which plane
planeIDs = get(handles.planeSelect,'String');
whichPlane = str2double(planeIDs(get(handles.planeSelect,'Value')));

%subset imSub based on conditions
cond1SubInd = findTrials(imSub,parsedSub{1});
cond2SubInd = findTrials(imSub,parsedSub{3});

%subset neuronal data in actByNeuron
actByNeuronCond1 = cellfun(@(x) x(cond1SubInd,:),imData.actByNeuron{whichPlane},'UniformOutput',false);
actByNeuronCond2 = cellfun(@(x) x(cond2SubInd,:),imData.actByNeuron{whichPlane},'UniformOutput',false);

%get tailVal
if strcmp(parsedSub{2},'<')
    tailVal = 'left';
elseif strcmp(parsedSub{2},'>')
    tailVal = 'right';
end

%get nNeurons
nNeurons = length(actByNeuronCond1);

%initialize sigNeurons
sigNeurons = zeros(nNeurons,1);

%cycle through each neuron 
for i = 1:nNeurons
    
    %compare subsets
    pVals = ttest2(actByNeuronCond1{i},actByNeuronCond2{i},'Tail',tailVal,'alpha',options.subsetPValue);
    
    %get number of significant bins
    nSigBins = nansum(pVals);
    
    %check if meets criterion
    if nSigBins >= round(options.subsetPercBins*length(pVals)/100)
        sigNeurons(i) = 1;
    end
end

%get indices
sigNeurons = find(sigNeurons == 1);