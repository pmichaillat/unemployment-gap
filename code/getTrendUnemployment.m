%% getTrendUnemployment
% 
% Return trend of unemployment rate in the United States, 1960Q1--2018Q3
%
%% Syntax
%
%   [uTrend, timelineTrend] = getTrendUnemployment()
%
%% Output arguments
%
% * uTrend - 235-by-1 column vector
% * timelineTrend - 235-by-1 column vector
%
%% Description
%
% This function returns the trend of the US unemployment rate, 1960Q1--2018Q3, as well as the corresponding timeline. The timeline indicates the date of each trend observation: timelineTrend(i) is the date of the ith trend observation, which takes the value uTrend(i). Each element of the timeline is expressed in year.quarter format:
% * 1951.00 is 1951Q1
% * 1951.25 is 1951Q2
% * 1951.5 is 1951Q3
% * 1951.75 is 1951Q4
% * 1952.00 is 1952Q1
%
%% Data source
%
% The trend of the unemployment rate is produced by Crump et al. (2019) and stored in data.xlsx.
%

function [uTrend, timelineTrend] = getTrendUnemployment()

% Read the trend of the unemployment rate
uTrend = readmatrix('../data/data.xlsx', 'Sheet', 'Quarterly data', 'Range',' E39:E273')./100;

% Produce timeline for 1960Q1--2018Q3
timelineTrend = [1960:0.25:2018.5]';