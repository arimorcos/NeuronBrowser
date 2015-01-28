function plotNeuronBrowserData(handles,export,neuronNum)
%plotNeuronBrowserData.m Function which updates neuron browser data based
%on conditions and neuron number. Determines number of conditions, makes a
%plot for each condition consisting of a trial by trial heatmap and a trial
%averaged trace for each condition breakdown.
%
%INPUTS
%handles - structure of handles
%export - whether or not plotting for export
%neuronNum - neuron number to plot if exporting
%
%ASM 11/13

segRanges = 0:80:480;

if nargin < 2 || isempty(export)
    export = false;
end

%set current figure as display figure
if ~export
    set(0,'CurrentFigure',handles.figure);
end

%get options
options = get(handles.optionsButton,'UserData');

%get imData
imData = get(handles.neuronNum,'UserData');

%get imSub
imSub = imData.dataCell(imData.imTrials);

%get neuron number
if ~export
    neuronNum = str2double(get(handles.neuronNum,'String'));
end

%get condInfo
condInfo = get(handles.setConditions,'UserData');

%get which plane
planeIDs = get(handles.planeSelect,'String');
whichPlane = str2double(planeIDs(get(handles.planeSelect,'Value')));

%get neuron
nData = imData.actByNeuron{whichPlane}{neuronNum};

%determine number of conditions
nConds = length(condInfo.ranges);

%determine number of rows and columns
[nPlotRows,nPlotCols] = calcNSubplotRows(nConds);

%clear all handles axes
if isfield(imData,'heatHandles') && ~export
    toDelete = [imData.heatHandles(ishandle(imData.heatHandles)) ...
        imData.avgHandles(ishandle(imData.avgHandles)) ...
        imData.labels(ishandle(imData.labels)) ];
    toDelete(toDelete == 0) = [];
    delete(toDelete);
end

%generate handles array
imData.heatHandles = rand(1,nConds);
imData.avgHandles = rand(1,nConds);

%cycle through each condition to get data subsets
condNData = cell(1,nConds);
for i = 1:nConds
    %parse range
    rangeStr = condInfo.ranges{i}; %get range string
    if strcmp(rangeStr,':') %if everything
        rangeInd = ones(size(imData.imTrials));
    else
        if strfind(rangeStr,':') %if contains a :
            minVal = str2double(rangeStr(1:strfind(rangeStr,':')-1)); %min val is value before colon
            maxVal = rangeStr(strfind(rangeStr,':')+1:end); %max val is after colon
            if all(isstrprop(maxVal,'digit')) %if max val is a digit
                maxVal = str2double(maxVal); %max val is now that digit
            elseif strfind(maxVal,'end') %if contains end
                maxVal = regexp(maxVal,'end','split'); %cut out the end
                maxVal = maxVal{2}; %get everything after the end
                maxVal = eval([num2str(length(imData.dataCell)),maxVal]); %evaluate length of dataCell - value contained
            else
                error('Cannot parse range');
            end
        elseif all(isstrrprop(rangeStr,'digit')) %if only contains a digit
            minVal = str2double(rangeStr); %min val is value contained
            maxVal = length(imData.dataCell); %max value is length of data cell
        else
            error('Cannot parse range');
        end
        rangeInd = imData.imTrials >= minVal & imData.imTrials <= maxVal; %find the trials in imTrials between minVal and maxVal
    end
    rangeNData = nData(logical(rangeInd),:); %get trials from nData which match range
    rangeSub = imSub(rangeInd == 1); %get subset of imSub which match range
    
    %exclude turnaround trials
    if options.excludeTurnAroundTrials
        noTurnTrials = ~findTurnAroundTrials(rangeSub);
        rangeSub = rangeSub(noTurnTrials);
        rangeNData = nData(noTurnTrials,:);
    end
    
    %parse condition
    if strcmp(condInfo.conditions{i},'') %if isempty
        condNData{i} = rangeNData;
    else
        condSubInd = findTrials(rangeSub,condInfo.conditions{i}); %get indices within rangeSub which match condition
        condNData{i} = rangeNData(condSubInd,:); %get trials from rangeNData which match condition
    end
    
end

%get maximum and minimum values over all conditions
allData = cat(1,condNData{:});
maxData = max(allData(isfinite(allData)));
minData = min(allData(isfinite(allData)));
maxSTD = nanstd(allData(isfinite(allData)),1);
maxSTD = max(maxSTD);
meanAllData = nanmean(allData(isfinite(allData)),1);
minMean = min(meanAllData(:));
maxMean = max(meanAllData(:));

%designate spacing parameters
xOffsets = [0.04 0.05];
yOffsets = [0.13 0.025];
plotSpacing = [0.02 0.05];
divSpaces = 0.01;

%loop through each condition
for i = 1:nConds
    
    %generate positions for plots
    if export
        [plotPositions,genPositions] = calcSubplotDivPositions(nPlotRows,nPlotCols,2,options.divisionSpacing,i,...
            xOffsets,[0.075 0.075],plotSpacing,divSpaces);
    else
        [plotPositions,genPositions] = calcSubplotDivPositions(nPlotRows,nPlotCols,2,options.divisionSpacing,i,...
            xOffsets,yOffsets,plotSpacing,divSpaces);
    end
    
    %if no trials
    if isempty(condNData{i})
        imData.heatHandles(i) = subplot('Position',genPositions);
        text(0.2,0.4,'No Trials Match','FontSize',30);
        continue;
    end
    
    %%%%%%%%%%%%%%%%%%HEATMAP PLOT %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %create subplot
    imData.heatHandles(i) = subplot('Position',plotPositions(2,:));
    
    %plot heatmap
    imagesc(imSub{1}.imaging.yPosBins,1:size(condNData{i},1),condNData{i},[minData maxData]);
% imagesc(condNData{i},[minData maxData]);
    
    %turn off xTickLabels
    set(imData.heatHandles(i),'XTickLabel',{});
    
    %add title
    if strcmp(condInfo.conditions{i},'')
        title('all','FontWeight','Bold','FontSize',14);
    else
        title(condInfo.conditions{i},'FontWeight','Bold','FontSize',14);
    end
    
    %add ylabel if on left
    if i <= nPlotRows %if in first column
        imData.labels(2*i - 1) = ylabel('Trial #','FontSize',12,...
            'FontWeight','Bold');
    end
    
    %add on segment dividers
    hold on;
    for segRangeInd = 1:length(segRanges)
        line(repmat(segRanges(segRangeInd),1,2),[0 size(condNData{i},1)],'Color','r','LineStyle','--');
    end
    
    %%%%%%%%%%%%%%%%%%TRIAL AVERAGED PLOT %%%%%%%%%%%%%%%%%%%%%%
    imData.avgHandles(i) = subplot('Position',plotPositions(1,:));
    
    %take mean of data found above
    avgNData = nanmean(condNData{i},1); %mean of each column (ignoring nan)
    
    %get confidence intervals
    %         [upper,lower] = getConfInt(condNData{i},options.confidenceInterval);
    %         upper = avgNData + upper;
    %         lower = avgNData + lower;
    if size(condNData{i},1) > 1
        percBound = prctile(condNData{i},[100-((100-options.confidenceInterval)/2) ...
            (100-options.confidenceInterval)/2]);
        upper = percBound(1,:);
        lower = percBound(2,:);
    else
        upper = 0;
        lower = 0;
    end
    
    %get std
    if size(condNData{i}) > 1
        stdNData = nanstd(condNData{i},1);
    else
        stdNData = zeros(size(avgNData));
    end
    
    %plot trace
    if options.showConfidenceInterval
        shadedErrorBar(imSub{1}.imaging.yPosBins,avgNData,[upper; lower],'k');
    else
        shadedErrorBar(imSub{1}.imaging.yPosBins,avgNData,stdNData,'k');
    end
    
    %set ylabel if in first column
    if i <= nPlotRows
        imData.labels(2*i) = ylabel('Mean % dF/F','FontSize',12,...
            'FontWeight','Bold');
    end
    
    %set limits
    if options.showConfidenceInterval
        ylim([0.95*minData 1.05*maxData]);
    else
        ylim([(minMean - maxSTD) (maxMean + maxSTD)]);
    end
    xlim([min(imSub{1}.imaging.yPosBins) max(imSub{1}.imaging.yPosBins)]);
    
    %add on segment dividers
    for segRangeInd = 1:length(segRanges)
        line(repmat(segRanges(segRangeInd),1,2),get(gca,'ylim'),'Color','r','LineStyle','--');
    end
    
end

%create colorbar
caxis([minData maxData]);
cBar = colorbar('Position',[(0.25*xOffsets(2)+1 - xOffsets(2))...
    yOffsets(1) 0.25*xOffsets(2) 1 - sum(yOffsets)]);

%label x axis
if export
    imData.labels(2*nPlotRows + 1) = uicontrol('Style','text','String','Binned Y Position',...
        'Units','Normalized','Position',[0.4 0.03 0.2 0.025],'FontWeight',...
        'Bold','FontSize',20,'BackgroundColor',[0.8 0.8 0.8]);
else
    imData.labels(2*nPlotRows + 1) = uicontrol('Style','text','String','Binned Y Position',...
        'Units','Normalized','Position',[0.4 0.09 0.2 0.025],'FontWeight',...
        'Bold','FontSize',20);
end

%title if exporting
if export
    uicontrol('Style','text','String',sprintf('Neuron # %d',neuronNum),...
        'Units','Normalized','Position',[0.4 0.965 0.2 0.025],'FontWeight',...
        'Bold','FontSize',20,'BackgroundColor',[0.8 0.8 0.8]);
end

if ~export
    %store handles in imData
    set(handles.neuronNum,'UserData',imData);
end