%% getBreakDate
%
% Return dates of structural breaks in US Beveridge curve between 1951 and 2019
%
%% Syntax
% 
%   [T, nT, lowT, highT] = getBreakDate();
%
%% Output arguments
%
% * nT - scalar
% * T - nT-by-1 column vector
% * lowT - nT-by-1 column vector
% * highT - nT-by-1 column vector
%
%% Description
%
% This function manually inputs the dates of the strutural breaks in the US Beveridge curve between 1951 and 2019, and the 95% confidence intervals of the break dates. The break dates and their 95% confidence intervals are obtained with the Bai-Perron algorithm used to compute the Beveridge elasticity. 
%
% * The estimates of the break dates are stored in T.
% * The number of breaks is stored in nT. 
% * The low ends of the 95% confidence intervals for the break dates are stored in lowT.
% * The high ends of the 95% confidence intervals for the break dates are stored in highT.
% 
% All dates are expressed in number of quarters since 1951: 
% * 1 is 1951Q1.
% * 2 is 1951Q2.
% * 3 is 1951Q3.
% * 4 is 1951Q4.
% * 5 is 1952Q1.
%
%% Data source
%
% The estimation results are produced by the script baiPerron.m.
%

function [T, nT, lowT, highT] = getBreakDate()

% Input estimate of break dates
T = [41; 84; 153; 194; 235];

% Input low end of 95% confidence interval for break dates
lowT =  [40; 80; 152; 193; 232];

% Input high end of 95% confidence interval for break dates
highT = [48; 89; 160; 200; 237];

% Count number of breaks
nT = length(T);