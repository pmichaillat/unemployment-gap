%% measureJobSeparation
% 
% Measure job-separation rate in the United States, 1951--2019
%
%% Syntax
%
%   lambda = measureJobSeparation(frequency)
%
%% Arguments
%
% * frequency  - 'monthly' or 'quarterly'
% * lambda - 828-by-1 column vector if frequency = 'monthly' and 276-by-1 column vector if frequency = 'quarterly'
%
%% Description
%
% The function measures the job-separation rate lambda in the United States, 1951--2019, from the unemployment level and labor-force size. The measurement method was proposed by Shimer (2012) and is described in online appendix B.
%
% *  If frequency = 'monthly', the rate lambda is expressed in jobs per month and reported as a monthly series
% * If frequency = 'quarterly', the rate lambda is expressed in jobs per quarter and reported as a quarterly series
% 
%% Data sources
%
% The unemployment level and labor-force size for the United States are produced by the Bureau of Labor Statistics (2020) and stored in data.xlsx.
%

function lambda = measureJobSeparation(frequency)

%% --- Get data ---

% Read monthly unemployment level
u = readmatrix('../data/data.xlsx', 'Sheet', 'Monthly data', 'Range',' D3:D831');

% Read monthly labor-force size
h = readmatrix('../data/data.xlsx', 'Sheet', 'Monthly data', 'Range',' F3:F830');

% Get monthly job-finding rate
f = measureJobFinding('monthly');

%% --- Compute job-separation rate ---

% Setup grids to solve for the monthly job-separation rate every month
lambdaRange = [0:10^(-6):0.1];
[fGrid, lambdaGrid] = ndgrid(f, lambdaRange);

% Reshape data as grids
col = size(lambdaGrid,2);
uGrid = repmat(u(1:end-1), 1, col);
hGrid = repmat(h, 1, col);

% Setup a grid with next period's unemployment level
uNextGrid = repmat(u(2:end), 1, col);

% Evaluate the distance between the left-hand and right-hand sides of equation (A9) on the grid
distance = abs((1 - exp(-(fGrid + lambdaGrid))) .* hGrid .* lambdaGrid ./ (fGrid + lambdaGrid) + uGrid .* exp(-(fGrid + lambdaGrid)) - uNextGrid); 

% Each month, find the job-separation rate that minimizes the distance
[M, I] = min(distance, [], 2);
lambda = lambdaRange(I)';

%% --- Adjust the unit and frequency of the job-separation rate ---

if strcmp(frequency, 'quarterly')

	% Express rate in jobs per quarter instead of jobs per month
	lambda = 3 .* lambda;

	% Take quarterly average of monthly series
	lambda = monthlyToQuarterly(lambda);

end