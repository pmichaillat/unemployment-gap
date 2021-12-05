%% figureA8.m
% 
% Produce figure A8
%
%% Description
%
% This script produces figure A8. 
%
% * Panel A displays labor productivity and its trend in the United States, 1951--2019.
% * Panel B displays detrended labor productivity the United States, 1951--2019.
%
%% Output
%
% * The two panels of the figure are saved as figureA8A.pdf and figureA8B.pdf.
% * The underlying data are saved in figureA8.xlsx.
%

close all
clear
clc

%% --- Get data ---

% Get timeline
timeline = getTimeline();

% Get recessions dates
[startRecession, endRecession, nRecession] = getRecessionDate();

% Get quarterly labor productivity
p = getLaborProductivity();

%% --- Detrend labor productivity ---

[pBar, pHat] = hpfilter(log(p), 1600);

% Convert trend and detrended productivity from log to level
pBar = exp(pBar);
pHat = exp(pHat);

%% --- Format figure & plot ---

formatFigure
formatPlot

%% --- Produce figure ---

%% Produce panel A

figure(1)
clf
hold on

% Paint recession areas
for iRecession = 1 : nRecession
	area([startRecession(iRecession), endRecession(iRecession)], [200,200], areaSetting{:});
end

% Plot productivity and trend
plot(timeline, p, purpleSetting{:})
plot(timeline, pBar, thinOrangeSetting{:})

% Populate axes
set(gca, xSetting{:})
set(gca, 'yLim', [0,120], 'yTick', [0:30:120])
ylabel('Labor-productivity index')

% Print figure
print('-dpdf', 'figureA8A.pdf')

%% Produce panel B

figure(2)
clf
hold on

% Paint recession areas
for iRecession = 1 : nRecession
	area([startRecession(iRecession), endRecession(iRecession)], [200,200], areaSetting{:});
end

% Plot detrended productivity
plot(timeline, pHat, purpleSetting{:})

% Populate axes
set(gca, xSetting{:})
set(gca, 'yLim', [0.94,1.06], 'yTick', [0.94:0.03:1.06])
ylabel('Detrended labor productivity')

% Print figure
print('-dpdf', 'figureA8B.pdf')

%% --- Save results ---

file = 'figureA8.xlsx';
sheet = 'Figure A8';

% Write header
header = {'Date', 'Labor productivity', 'Trend labor productivity', 'Detrended labor productivity'};
writecell(header, file, 'Sheet', sheet, 'WriteMode', 'replacefile')

% Write results
result = [timeline, p, pBar, pHat];
writematrix(result, file, 'Sheet', sheet, 'WriteMode', 'append')