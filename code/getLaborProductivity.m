%% getLaborProductivity
% 
% Return quarterly labor productivity in the United States, 1951--2019
%
%% Syntax
%
%   p = getLaborProductivity()
%
%% Output arguments
%
% * p - 276-by-1 column vector
%
%% Description
%
% This function returns the real output per person in the United States, 1951--2019. The real output per person is measured as an index (2012 = 100) and available as a quarterly series. 
%
%% Data source
%
% The real output per person is produced by the Bureau of Labor Statistics (2020) and stored in data.xlsx.
%

function p = getLaborProductivity()

% Read labor productivity
p = readmatrix('../data/data.xlsx', 'Sheet', 'Quarterly data', 'Range',' D3:D278');