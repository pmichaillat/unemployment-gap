%% getBeveridgeElasticity
%
% Return Beveridge elasticity in the United States, 1951--2019
%
%% Syntax
% 
%   [epsilon, epsilonLow, epsilonHigh] = getBeveridgeElasticity()
%
%% Output arguments
%
% * epsilon - 276-by-1 column vector
% * epsilonLow - 276-by-1 column vector
% * epsilonHigh - 276-by-1 column vector
%
%% Description
%
% This function returns the elasticity of the US Beveridge curve in each quarter between 1951 and 2019, and its 95% confidence interval. The elasticity and its 95% confidence interval are estimated with the Bai-Perron algorithm. 
%
% * The estimate of the Beveridge elasticity is stored in epsilon.
% * The low end of the 95% confidence interval for the Beveridge elasticity is stored in lowT.
% * The high end of the 95% confidence interval for the Beveridge elasticity is stored in highT.
%
%% Data source
%
% The estimation results are produced by the script baiPerron.m.
%

function [epsilon, epsilonLow, epsilonHigh] = getBeveridgeElasticity()

%% --- Get data ---

% Get timeline
[timeline, nQuarter] = getTimeline();

% Get Beveridge-curve break dates
[T, nT] = getBreakDate();

%% --- Input Beveridge elasticity ---

% Input estimate of Beveridge elasticity
epsilonEstimate = [0.8437, 1.0182, 0.8376, 0.9390, 0.9985, 0.8364];

% Input corrected standard error for Beveridge elasticity
se = [0.066707, 0.068795, 0.11244, 0.14772, 0.057224, 0.056694];

%% --- Construct time series for Beveridge elasticity & its 95% confidence interval ---

%% Input start and end dates for Beveridge-curve branches

nBranch = nT + 1;
startBranch = [1; T + 1];
endBranch = [T; nQuarter];

%% Pick z value to construct confidence interval

confidence = 0.95;
p = 1 - ((1 - confidence)./2);
z = norminv(p);

%% Construct time series branch by branch

for iBranch = 1 : nBranch

	% Construct series for Beveridge elasticity
	epsilon(startBranch(iBranch) : endBranch(iBranch),1) = epsilonEstimate(iBranch);

	% Construct series for bottom-end of 95% confidence interval
	epsilonLow(startBranch(iBranch) : endBranch(iBranch),1) = epsilonEstimate(iBranch) - z .* se(iBranch);

	% Construct series for top-end of 95% confidence interval
	epsilonHigh(startBranch(iBranch) : endBranch(iBranch),1) = epsilonEstimate(iBranch) + z .* se(iBranch);
end	
