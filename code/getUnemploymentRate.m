%% getUnemploymentRate
% 
% Return quarterly unemployment rate in the United States, 1951--2019
%
%% Syntax
%
%   u = getUnemploymentRate()
%
%% Output arguments
%
% * u - 276-by-1 column vector
%
%% Description
%
% This function reads the US unemployment rate, 1951--2019, and returns the quarterly average of this monthly series. 
%
%% Data source
%
% The unemployment rate is produced by the Bureau of Labor Statistics (2020) and stored in data.xlsx.
%

function u = getUnemploymentRate()

% Input monthly unemployment rate
u = readmatrix('../data/data.xlsx', 'Sheet', 'Monthly data', 'Range',' C3:C830')./100;

% Take quarterly average of monthly series
u = monthlyToQuarterly(u);