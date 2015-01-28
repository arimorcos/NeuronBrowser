function [upper,lower] = getConfInt(in,perc)
%getConfInt.m Function to get confidence interval of array along the first
%dimension
%
%INPUTS
%in - m x n array
%perc - percent confidence interval
%
%OUTPUTS
%upper - 1 x n array of upper bounds
%lower - 1 x n array of lower bounds
%
%ASM 11/13

%parse perc
percInt = (100 - perc)/2;
lowerFrac = percInt/100;
upperFrac = (100 - percInt)/100;

%sort list
sortedIn = sort(in,1);

%find length of each column not including nan
nRows = size(in,1);
nNAN = sum(isnan(in));
nVals = nRows - nNAN;

%find lower and upper ind
lowerInd = max(1,floor(lowerFrac*nVals));
upperInd = max(1,ceil(upperFrac*nVals));

%store in lower
lower = sortedIn(sub2ind(size(in),lowerInd,1:size(in,2)));
upper = sortedIn(sub2ind(size(in),upperInd,1:size(in,2)));