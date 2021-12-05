%% figure7B.m
% 
% Produce figure 7B
%
%% Description
%
% This script produces figure 7B. The figure displays the efficient unemployment rate in the United States, 1951--2019. The figure also displays the US unemployment rate as a benchmark.
%
%% Output
%
% * Figure 7B is saved as figure7B.pdf.
% * The underlying data are saved in figure7B.xlsx.
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

%% ---  Get sufficient statistics ---

% Get Beveridge elasticity
epsilon = getBeveridgeElasticity();

% Input the social value of nonwork estimated in section 5.2
zeta = 0.26;

% Input the recruiting cost estimated in section 5.3
kappa = 0.92; 

%% --- Compute efficient unemployment rate ---

uStar = computeEfficientUnemployment(epsilon, zeta, kappa, u, v);

%% --- Format figure & plot ---

formatFigure
formatPlot

%% --- Produce figure  ---

figure(1)
clf
hold on

% Paint recession areas
for iRecession = 1 : nRecession
	area([startRecession(iRecession), endRecession(iRecession)], [2,2], areaSetting{:});
end

% Paint unemployment gap
a = area(timeline, [uStar, max(u - uStar,0), min(u - uStar,0)], 'LineStyle', 'none');
a(1).FaceAlpha = 0;
a(2).FaceAlpha = 0.2;
a(3).FaceAlpha = 0.2;
a(2).FaceColor = purple;
a(3).FaceColor = pink;

% Plot actual unemployment rate
plot(timeline, u, purpleSetting{:})

% Plot efficient unemployment rate
plot(timeline, uStar, pinkSetting{:})

% Populate axes
set(gca, xSetting{:})
set(gca, 'yLim', [0,0.12], 'yTick', [0:0.03:0.12], 'yTickLabel', [' 0%';' 3%';' 6%';' 9%';'12%'])
ylabel('Unemployment rate')

% Print figure
print('-dpdf', 'figure7B.pdf')

%% --- Save results ---

file = 'figure7B.xlsx';
sheet = 'Figure 7B';

% Write header
header = {'Date', 'Unemployment rate', 'Efficient unemployment rate'};
writecell(header, file, 'Sheet', sheet, 'WriteMode', 'replacefile')

% Write results
result = [timeline, u, uStar];
writematrix(result, file, 'Sheet', sheet, 'WriteMode', 'append')