%% getNairu
% 
% Return NAIRU in the United States, 1960Q1--2018Q3
%
%% Syntax
%
%   [uNairu, timelineNairu] = getNairu()
%
%% Output arguments
%
% * uNairu - 235-by-1 column vector
% * timelineNairu - 235-by-1 column vector
%
%% Description
%
% This function returns the NAIRU in the United States, 1960Q1--2018Q3, as well as the corresponding timeline. The timeline indicates the date of each NAIRU observation: timelineNairu(i) is the date of the ith NAIRU observation, which takes the value uNairu(i). Each element of the timeline is expressed in year.quarter format:
% * 1951.00 is 1951Q1
% * 1951.25 is 1951Q2
% * 1951.5 is 1951Q3
% * 1951.75 is 1951Q4
% * 1952.00 is 1952Q1
%
%% Data source
%
% The NAIRU is produced by Crump et al. (2019) and stored in data.xlsx.
%

function [uNairu, timelineNairu] = getNairu()

% Read NAIRU
uNairu = readmatrix('../data/data.xlsx', 'Sheet', 'Quarterly data', 'Range',' F39:F273')./100;

% Produce timeline for 1960Q1--2018Q3
timelineNairu = [1960:0.25:2018.5]';