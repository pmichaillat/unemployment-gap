%% figureA6.m
% 
% Produce figure A6
%
%% Description
%
% This script produces figure A6. The figure displays the quarterly matching efficacy from the DMP model for the United States, 1951--2019.
%
%% Output
%
% * The figure is saved as figureA6.pdf.
% * The underlying data are saved in figureA6.xlsx.
%

close all
clear
clc

%% --- Get data ---

% Get timeline
timeline = getTimeline();

% Get recessions dates
[startRecession, endRecession, nRecession] = getRecessionDate();

% Get unemployment rate
u = getUnemploymentRate();

% Get vacancy rate
v = getVacancyRate();

% Compute labor-market tightness
theta= v./u;

% Get Beveridge efficacy
epsilon = getBeveridgeElasticity();

% Measure job-finding rate
f = measureJobFinding('quarterly');

%% --- Compute matching efficacy ---

% Compute matching elasticity
eta = computeMatchingElasticity(epsilon, u);

% Compute quarterly matching efficacy
omega = computeMatchingEfficacy(f, theta, eta);

%% --- Format figure & plot ---

formatFigure
formatPlot

%% --- Produce figure ---

figure(1)
clf
hold on

% Paint recession areas
for iRecession = 1 : nRecession
	area([startRecession(iRecession), endRecession(iRecession)], [10,10], areaSetting{:});
end

% Plot matching efficacy
plot(timeline, omega, purpleSetting{:})

% Populate axes
set(gca, xSetting{:})
set(gca, 'yLim', [0,4])
ylabel('Quarterly matching efficacy')

% Print figure
print('-dpdf', 'figureA6.pdf')

%% --- Save results ---

file = 'figureA6.xlsx';
sheet = 'Figure A6';

% Write header
header = {'Date', 'Quarterly matching efficacy'};
writecell(header, file, 'Sheet', sheet, 'WriteMode', 'replacefile')

% Write results
result = [timeline, omega];
writematrix(result, file, 'Sheet', sheet, 'WriteMode', 'append')