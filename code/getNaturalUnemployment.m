%% getNaturalUnemployment
% 
% Return natural rate of unemployment in the United States, 1951--2019
%
%% Syntax
%
%   [uNatural, timelineNatural] = getNaturalUnemployment()
%
%% Output arguments
%
% * uNatural - 276-by-1 column vector
% * timelineNatural - 276-by-1 column vector
%
%% Description
%
% This function returns the natural rate of unemployment in the United States, 1951--2019, as well as the corresponding timeline. The timeline indicates the date of each observation of the natural rate: timelineNatural(i) is the date of the ith observation, which takes the value uNatural(i). Each element of the timeline is expressed in year.quarter format:
% * 1951.00 is 1951Q1
% * 1951.25 is 1951Q2
% * 1951.5 is 1951Q3
% * 1951.75 is 1951Q4
% * 1952.00 is 1952Q1
%
%% Data source
%
% The natural rate of unemployment is produced by the Congressional Budget Office (2020) and stored in data.xlsx.
%

function [uNatural, timelineNatural] = getNaturalUnemployment()

% Read NAIRU
uNatural = readmatrix('../data/data.xlsx', 'Sheet', 'Quarterly data', 'Range',' C3:C278')./100;

% Produce timeline for 1951Q1--2019Q4
timelineNatural = [1951:0.25:2019.75]';