%% figure8B.m
% 
% Produce figure 8B
%
%% Description
%
% This script produces figure 8B. The figure displays the efficient unemployment rate in the United States, 1951--2019, under 3 different calibrations of the sufficient statistics:
% * with the social value of nonwork calibrated to its midpoint estimate
% * with the social value of nonwork calibrated to its low-end estimate
% * with the social value of nonwork calibrated to its high-end estimate
%
% The figure also displays the US unemployment rate as a benchmark.
%
%% Output
%
% * Figure 8B is saved as figure8B.pdf.
% * The underlying data are saved in figure8B.xlsx.
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

% Input the midpoint, low-end, and high-end estimates of the social value of nonwork described in section 5.2
zeta = 0.26;
zetaLow = 0.03;
zetaHigh = 0.49;

% Input the recruiting cost estimated in section 5.3
kappa = 0.92; 

%% --- Compute efficient unemployment rate for different social values of nonwork ---

% Use midpoint estimate of social value of nonwork
uStar = computeEfficientUnemployment(epsilon, zeta, kappa, u, v);

% Use low-end estimate of social value of nonwork
uStarZetaLow = computeEfficientUnemployment(epsilon, zetaLow, kappa, u, v);

% Use high-end estimate of social value of nonwork
uStarZetaHigh = computeEfficientUnemployment(epsilon, zetaHigh, kappa, u, v);

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

% Plot actual unemployment rate
plot(timeline, u, purpleSetting{:})

% Paint plausible interval for efficient unemployment rate
a = area(timeline, [uStarZetaLow, uStarZetaHigh - uStarZetaLow], 'LineStyle', 'none');
a(1).FaceAlpha = 0;
a(2).FaceAlpha = 0.2;
a(2).FaceColor = pink;

% Plot different efficient unemployment rates
plot(timeline, uStar, pinkSetting{:})
plot(timeline, uStarZetaLow, thinPinkSetting{:})
plot(timeline, uStarZetaHigh, thinPinkSetting{:})

% Populate axes & print
set(gca, xSetting{:})
set(gca, 'yLim', [0,0.12], 'yTick', [0:0.03:0.12], 'yTickLabel', [' 0%';' 3%';' 6%';' 9%';'12%'])
ylabel('Unemployment rate')

% Print figure
print('-dpdf', 'figure8B.pdf')

%% --- Save results ---

file = 'figure8B.xlsx';
sheet = 'Figure 8B';

% Write header
header = {'Date', 'Unemployment rate', 'Efficient unemployment rate', 'Efficient unemployment rate with low social value of nonwork', 'Efficient unemployment rate with high social value of nonwork'};
writecell(header, file, 'Sheet', sheet, 'WriteMode', 'replacefile')

% Write results
result = [timeline, u, uStar, uStarZetaLow, uStarZetaHigh];
writematrix(result, file, 'Sheet', sheet, 'WriteMode', 'append')

