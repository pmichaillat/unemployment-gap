%% figureA2.m
% 
% Produce figure A2
%
%% Description
%
% This script produces figure A2. The figure displays the quarterly job-separation rate in the United States, 1951--2019.
%
%% Output
%
% * The figure is saved as figureA2.pdf.
% * The underlying data are saved in figureA2.xlsx.
%

close all
clear
clc

%% --- Get data ---

% Get timeline
timeline = getTimeline();

% Get recessions dates
[startRecession, endRecession, nRecession] = getRecessionDate();

% Measure job-separation rate
lambda = measureJobSeparation('quarterly');

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

% Plot job-separation rate
plot(timeline, lambda, purpleSetting{:})

% Populate axes
set(gca, xSetting{:})
set(gca, 'yLim', [0,0.2])
ylabel('Quarterly job-separation rate')

% Print figure
print('-dpdf', 'figureA2.pdf')

%% --- Save results ---

file = 'figureA2.xlsx';
sheet = 'Figure A2';

% Write header
header = {'Date', 'Quarterly job-separation rate'};
writecell(header, file, 'Sheet', sheet, 'WriteMode', 'replacefile')

% Write results
result = [timeline, lambda];
writematrix(result, file, 'Sheet', sheet, 'WriteMode', 'append')