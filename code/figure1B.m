%% figure1B.m
% 
% Produce figure 1B
%
%% Description
%
% This script produces figure 1B. The figure displays the quarterly vacancy rate in the United States, 1951--2019.
%
%% Output
%
% * The figure is saved as figure1B.pdf.
% * The underlying data are saved in figure1B.xlsx.
%

close all
clear
clc

%% --- Get data ---

% Get timeline
timeline = getTimeline();

% Get recessions dates
[startRecession, endRecession, nRecession] = getRecessionDate();

% Get vacancy rate
v = getVacancyRate();

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

% Plot vacancy rate
plot(timeline, v, purpleSetting{:})

% Populate axes
set(gca, xSetting{:})
set(gca, 'yLim', [0,0.05], 'yTick', [0:0.01:0.05], 'yTickLabel', ['0%';'1%';'2%';'3%';'4%';'5%'])
ylabel('Vacancy rate')

% Print figure
print('-dpdf', 'figure1B.pdf')

%% --- Save results ---

file = 'figure1B.xlsx';
sheet = 'Figure 1B';

% Write header
header = {'Date', 'Vacancy rate'};
writecell(header, file, 'Sheet', sheet, 'WriteMode', 'replacefile')

% Write results
result = [timeline, v];
writematrix(result, file, 'Sheet', sheet, 'WriteMode', 'append')
