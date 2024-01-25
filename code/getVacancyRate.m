%% getVacancyRate
% 
% Return quarterly vacancy rate in the United States, 1951--2019
%
%% Syntax
%
%   v = getVacancyRate()
%
%% Output arguments
%
% * v - 276-by-1 column vector
%
%% Description
%
% This function constructs the US vacancy rate, 1951--2019, by following the steps described in section 2.2:
% # The function reads the US vacancy rate, 1951--2000.
% # The function reads the US vacancy and labor-force levels, 2001--2019, and divides vacancy level by labor-force level to obtain the US vacancy rate, 2001--2019. 
% # The function splices the two vacancy-rate series to produce the monthly vacancy rate in the United States, 1951--2019.
% # The function returns the quarterly average of the monthly vacancy series. 
%
%% Data sources
%
% * US vacancy rate, 1951--2000 - Barnichon (2010)
% * US vacancy level, 2001--2019 - Bureau of Labor Statistics (2020)
% * US labor-force level, 2001--2019 - Bureau of Labor Statistics (2020)
%
% The data are stored in data.xlsx.
%

function v = getVacancyRate()

% Read monthly vacancy rate for 1951--2000
v1951 = readmatrix('../data/data.xlsx', 'Sheet', 'Monthly data', 'Range', 'H3:H602')./100;

% Read monthly vacancy level for 2001--2019
v2001 = readmatrix('../data/data.xlsx', 'Sheet', 'Monthly data', 'Range', 'G603:G830');

% Read monthly labor-force level for 2001--2019
laborforce = readmatrix('../data/data.xlsx', 'Sheet', 'Monthly data', 'Range', 'F603:F830');

% Compute vacancy rate for 2001--2019
v2001 = v2001 ./ laborforce;

% Splice monthly vacancy rates for 1951--2019
v = [v1951; v2001];

% Take quarterly average of monthly series
v = monthlyToQuarterly(v);