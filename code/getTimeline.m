%% getTimeline
% 
% Return quarterly timeline for 1951Q1--2019Q4
%
%% Syntax
%
%   [timeline, nQuarter] = getTimeline()
%
%% Output arguments
%
% * nQuarter - scalar
% * timeline - nQuarter-by-1 column vector
%
%% Description
%
% This function returns the quarterly timeline for 1951Q1--2019Q4, expressed in year.quarter format:
% * 1951.00 is 1951Q1
% * 1951.25 is 1951Q2
% * 1951.5 is 1951Q3
% * 1951.75 is 1951Q4
% * 1952.00 is 1952Q1
%
% * The quarterly timeline is stored in timeline.
% * The number of quarters between 1951Q1 & 2019Q4 is stored in nQuarter.
%

function [timeline, nQuarter] = getTimeline()

% Produce timeline for 1951Q1--2019Q4
timeline = [1951:0.25:2019.75]';

% Count number of quarters in 1951Q1--2019Q4
nQuarter = length(timeline);