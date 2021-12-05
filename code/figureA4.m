%% figureA4.m
% 
% Produce figure A4
%
%% Description
%
% This script produces figure A4. The figure displays the matching elasticity from the DMP model for the United States, 1951--2019.
%
%% Output
%
% * The figure is saved as figureA4.pdf.
% * The underlying data are saved in figureA4.xlsx.
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

% Get Beveridge elasticity
epsilon = getBeveridgeElasticity();

%% --- Compute matching elasticity ---

eta = computeMatchingElasticity(epsilon, u);

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

% Plot matching elasticity
plot(timeline, eta, purpleSetting{:})

% Populate axes
set(gca, xSetting{:})
set(gca, 'yLim', [0,0.6], 'yTick', [0:0.2:0.6])
ylabel('Matching elasticity')

% Print figure
print('-dpdf', 'figureA4.pdf')

%% --- Save results ---

file = 'figureA4.xlsx';
sheet = 'Figure A4';

% Write header
header = {'Date', 'Matching elasticity'};
writecell(header, file, 'Sheet', sheet, 'WriteMode', 'replacefile')

% Write results
result = [timeline, eta];
writematrix(result, file, 'Sheet', sheet, 'WriteMode', 'append')