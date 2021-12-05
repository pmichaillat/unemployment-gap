%% figure8A.m
% 
% Produce figure 8A
%
%% Description
%
% This script produces figure 8A. The figure displays the efficient unemployment rate in the United States, 1951--2019, under 3 different calibrations of the sufficient statistics:
% * with the Beveridge elasticity calibrated to its point estimate
% * with the Beveridge elasticity calibrated to the low end of its 95% confidence interval
% * with the Beveridge elasticity calibrated to the high end of its 95% confidence interval
%
% The figure also displays the US unemployment rate as a benchmark.
%
%% Output
%
% * Figure 8A is saved as figure8A.pdf.
% * The underlying data are saved in figure8A.xlsx.
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

% Get point estimate of Beveridge elasticity, and low and high ends of its 95% confidence interval 
[epsilon, epsilonLow, epsilonHigh] = getBeveridgeElasticity();

% Input the social value of nonwork estimated in section 5.2
zeta = 0.26;

% Input the recruiting cost estimated in section 5.3
kappa = 0.92; 

%% --- Compute efficient unemployment rate for different Beveridge elasticities ---

% Use point estimate of Beveridge elasticity
uStar = computeEfficientUnemployment(epsilon, zeta, kappa, u, v);

% Use low-end estimate of Beveridge elasticity
uStarEpsilonLow = computeEfficientUnemployment(epsilonLow, zeta, kappa, u, v);

% Use high-end estimate of Beveridge elasticity
uStarEpsilonHigh = computeEfficientUnemployment(epsilonHigh, zeta, kappa, u, v);

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
a = area(timeline, [uStarEpsilonLow, uStarEpsilonHigh - uStarEpsilonLow], 'LineStyle', 'none');
a(1).FaceAlpha = 0;
a(2).FaceAlpha = 0.2;
a(2).FaceColor = pink;

% Plot different efficient unemployment rates
plot(timeline, uStar, pinkSetting{:})
plot(timeline, uStarEpsilonLow, thinPinkSetting{:})
plot(timeline, uStarEpsilonHigh, thinPinkSetting{:})

% Populate axes
set(gca, xSetting{:})
set(gca, 'yLim', [0,0.12], 'yTick', [0:0.03:0.12], 'yTickLabel', [' 0%';' 3%';' 6%';' 9%';'12%'])
ylabel('Unemployment rate')

% Print figure
print('-dpdf', 'figure8A.pdf')

%% --- Save results ---

file = 'figure8A.xlsx';
sheet = 'Figure 8A';

% Write header
header = {'Date', 'Unemployment rate', 'Efficient unemployment rate', 'Efficient unemployment rate with low Beveridge elasticity', 'Efficient unemployment rate with high Beveridge elasticity'};
writecell(header, file, 'Sheet', sheet, 'WriteMode', 'replacefile')

% Write results
result = [timeline, u, uStar, uStarEpsilonLow, uStarEpsilonHigh];
writematrix(result, file, 'Sheet', sheet, 'WriteMode', 'append')