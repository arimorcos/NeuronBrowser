function [nRows,nCol] = calcNSubplotRows(nPlots)
%calcNSubplotRows.m simple function which determines the nearest greater
%square for plots
%
%INPUTS 
%nPlots - number of plots
%
%OUTPUTS
%nRows - number of rows in plot
%
%ASM 11/13

if nPlots > 4 && nPlots <= 6
    nRows = 2;
    nCol = 3;
    return;
elseif nPlots == 2
    nRows = 1;
    nCol = 2;
    return;
end

%get list of squares between 1 and 100
squares = (1:100).^2;

%find first item less than or equal
rowInd = find(nPlots <= squares,1,'first');

%get square value
squareVal = squares(rowInd);

%take square root
nRows = sqrt(squareVal);
nCol = nRows;

%remove rows if necessary
while nCol*nRows > nPlots + nCol
    nRows = nRows - 1;
end
