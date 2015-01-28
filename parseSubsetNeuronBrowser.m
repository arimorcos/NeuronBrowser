function parsedStr = parseSubsetNeuronBrowser(str)
%parseSubsetNeuronBrowser.m Function to parse subset strings for the neuron
%browser 3000
%
%INPUTS
%str - str to be parsed 
%
%OUTPUTS
%parsedStr - 1 x 3 cell array containing condition 1, operator and
%   condition 2. If empty, threw an error
%
%ASM 11/13


%check if underscores are present correctly
if isempty(regexp(str,'_._','match'))
    errordlg('Operator must be surrounded by underscores');
    parsedStr = {};
    return;
end

%find conditions surrounded by underscores
conditions = regexp(str,'_._','split');

%if not two conditions
if length(conditions) > 2 
    errordlg('Cannot process more than two conditions');
    parsedStr = {};
    return;
elseif length(conditions) < 2
    errordlg('Cannot process fewer than two conditions');
    parsedStr = {};
    return;
end

%store conditions in parseStr
parsedStr{1} = conditions{1};
parsedStr{3} = conditions{2};

%find out identity of operator
operator = regexp(str,'(?<=_).(?=_)','match');

%check if matches greater than or less than
if ~ismember(operator,{'<','>'})
    errordlg(sprintf('Cannot recognize %s operator',operator));
    parsedStr = {};
    return;
end

%store operator
parsedStr{2} = operator{1};
