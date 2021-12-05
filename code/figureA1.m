%% figureA1.m
% 
% Produce figure A1
%
%% Description
%
% This script produces figure A1. The figure displays the quarterly job-finding rate in the United States, 1951--2019.
%
%% Output
%
% * The figure is saved as figureA1.pdf.
% * The underlying data are saved in figureA1.xlsx.
%

close all
clear
clc

%% --- Get data ---

% Get timeline
timeline = getTimeline();

% Get recessions dates
[startRecession, endRecession, nRecession] = getRecessionDate();

% Measure job-finding rate
f = measureJobFinding('quarterly');

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

% Plot job-finding rate
plot(timeline, f, purpleSetting{:})

% Populate axes
set(gca, xSetting{:})
set(gca, 'yLim', [0,4])
ylabel('Quarterly job-finding rate')

% Print figure
print('-dpdf', 'figureA1.pdf')

%% --- Save results ---

file = 'figureA1.xlsx';
sheet = 'Figure A1';

% Write header
header = {'Date', 'Quarterly job-finding rate'};
writecell(header, file, 'Sheet', sheet, 'WriteMode', 'replacefile')

% Write results
result = [timeline, f];
writematrix(result, file, 'Sheet', sheet, 'WriteMode', 'append')