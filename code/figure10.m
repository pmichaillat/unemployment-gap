%% figure10.m
% 
% Produce figure 10
%
%% Description
%
% This script produces figure 10. The figure displays the efficient unemployment rate in the United States, 1951--2019, when the social value of nonwork is calibrated as in Hagedorn and Manovskii (2008).
%
% The figure also displays the US unemployment rate as a benchmark.
%
%% Output
%
% * Figure 10 is saved as figure10.pdf.
% * The underlying data are saved in figure10.xlsx.
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

% Input the social value of nonwork proposed by Hagedorn and Manovskii (2008)
zetaHm = 0.96;

% Input the recruiting cost estimated in section 5.3
kappa = 0.92; 

%% --- Compute efficient unemployment rate ---

uStarHm = computeEfficientUnemployment(epsilon,zetaHm,kappa,u,v);

%% --- Format figure & plot ---

formatFigure
formatPlot

%% --- Plot efficient unemployment rate  ---

figure(1)
clf
hold on

% Paint recession areas
for iRecession = 1 : nRecession
	area([startRecession(iRecession), endRecession(iRecession)], [2,2], areaSetting{:});
end

% Paint unemployment gap
a = area(timeline, [uStarHm, max(u - uStarHm,0), min(u - uStarHm,0)], 'LineStyle','none');
a(1).FaceAlpha = 0;
a(2).FaceAlpha = 0.2;
a(3).FaceAlpha = 0.2;
a(2).FaceColor = purple;
a(3).FaceColor = pink;

% Plot actual unemployment rate
plot(timeline, u, purpleSetting{:})

% Plot efficient unemployment rate
plot(timeline, uStarHm, pinkSetting{:})

% Populate axes
set(gca, xSetting{:})
set(gca, 'yLim', [0,0.3], 'yTick',[0:0.1:0.3], 'yTickLabel', [' 0%';'10%';'20%';'30%'])
ylabel('Unemployment rate')

% Print figure
print('-dpdf', 'figure10.pdf')

%% --- Save results ---

file = 'figure10.xlsx';
sheet = 'Figure 10';

% Write header
header = {'Date', 'Unemployment rate', 'Efficient unemployment rate'};
writecell(header, file, 'Sheet', sheet, 'WriteMode', 'replacefile')

% Write results
result = [timeline, u, uStarHm];
writematrix(result, file, 'Sheet', sheet, 'WriteMode', 'append')

