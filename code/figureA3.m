%% figureA3.m
% 
% Produce figure A3
%
%% Description
%
% This script produces figure A3. The figure displays the Beveridgean unemployment rate from the DMP model for the United States, 1951--2019. The figure also displays the US unemployment rate as a benchmark.
%
%% Output
%
% * The figure is saved as figureA3.pdf.
% * The underlying data are saved in figureA3.xlsx.
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

% Get job-finding rate
f = measureJobFinding('quarterly');

% Get job-separation rate
lambda = measureJobSeparation('quarterly');

%% --- Compute Beveridgean unemployment rate ---

ub = computeBeveridgeanUnemployment(f, lambda);

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

% Plot unemployment rate
plot(timeline, u, purpleSetting{:})

% Plot Beveridgean unemployment rate
plot(timeline, ub, orangeSetting{:})

% Populate axes
set(gca, xSetting{:})
set(gca, 'yLim', [0,0.12], 'yTick', [0:0.03:0.12], 'yTickLabel', [' 0%';' 3%';' 6%';' 9%';'12%'])
ylabel('Unemployment rate')

% Print figure
print('-dpdf', 'figureA3.pdf')

%% --- Save results ---

file = 'figureA3.xlsx';
sheet = 'Figure A3';

% Write header
header = {'Date', 'Unemployment rate', 'Beveridgean unemployment rate'};
writecell(header, file, 'Sheet', sheet, 'WriteMode', 'replacefile')

% Write results
result = [timeline, u, ub];
writematrix(result, file, 'Sheet', sheet, 'WriteMode', 'append')