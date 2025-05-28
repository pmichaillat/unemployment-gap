%% figure1A.m
% 
% Produce figure 1A
%
%% Description
%
% This script produces figure 1A. The figure displays the quarterly unemployment rate in the United States, 1951--2019.
%
%% Output
%
% * The figure is saved as figure1A.pdf.
% * The underlying data are saved in figure1A.xlsx.
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

%% --- Format figure & plot ---

formatFigure
formatPlot

%% --- Produce figure ---

figure(1)
clf
hold on

% Paint recession areas
for iRecession = 1 : nRecession
	area([startRecession(iRecession), endRecession(iRecession)], [2,2], areaSetting{:});
end

% Plot unemployment rate
plot(timeline, u, purpleSetting{:})

% Populate axes
set(gca, xSetting{:})
set(gca, 'yLim', [0,0.12], 'yTick', [0:0.03:0.12], 'yTickLabel', [' 0%';' 3%';' 6%';' 9%';'12%'])
ylabel('Unemployment rate')

% Print figure
print('-dpdf', 'figure1A.pdf')

%% --- Save results ---

file = 'figure1A.xlsx';
sheet = 'Figure 1A';

% Write header
header = {'Date', 'Unemployment rate'};
writecell(header, file, 'Sheet', sheet, 'WriteMode', 'replacefile')

% Write results
result = [timeline, u];
writematrix(result, file, 'Sheet', sheet, 'WriteMode', 'append')


