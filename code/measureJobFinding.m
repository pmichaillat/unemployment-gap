%% measureJobFinding
% 
% Measure job-finding rate in the United States, 1951--2019
%
%% Syntax
%
%   f = measureJobFinding(frequency)
%
%% Arguments
%
% * frequency  - 'monthly' or 'quarterly'
% * f - 828-by-1 column vector if frequency = 'monthly' and 276-by-1 column vector if frequency = 'quarterly'
%
%% Description
%
% The function measures the job-finding rate in the United States, 1951--2019, from the unemployment level and short-term unemployment level. The measurement method was proposed by Shimer (2012) and is described in online appendix B.
%
% *  If frequency = 'monthly', the rate f is expressed in jobs per month and reported as a monthly series
% * If frequency = 'quarterly', the rate f is expressed in jobs per quarter and reported as a quarterly series
%
%% Data sources
%
% The unemployment level and short-term unemployment level for the United States are produced by the Bureau of Labor Statistics (2020) and stored in data.xlsx.
%

function f = measureJobFinding(frequency)

%% --- Get data ---

% Read monthly unemployment level
u = readmatrix('../data/data.xlsx', 'Sheet', 'Monthly data', 'Range',' D3:D831');

% Read monthly short-term unemployment level
uShortTerm = readmatrix('../data/data.xlsx', 'Sheet', 'Monthly data', 'Range',' E3:E831');

% Adjust short-term unemployment level after January 1994 as in Shimer (2012, appendix A)
uShortTerm(517:end) = 1.1 .* uShortTerm(517:end);

%% --- Compute job-finding rate ---

% Compute the monthly job-finding probability from equation (A7)
F = 1 - ((u(2:end) - uShortTerm(2:end)) ./ u(1:end-1));

% Compute the monthly job-finding rate from equation (A8)
f = -log(1 - F);

%% --- Adjust the unit and frequency of the job-finding rate ---

if strcmp(frequency, 'quarterly')

	% Express rate in jobs per quarter instead of jobs per month
	f = 3 .* f;

	% Take quarterly average of monthly series
	f = monthlyToQuarterly(f);

end