%% figure9A.m
% 
% Produce figure 9A
%
%% Description
%
% This script produces figure 9A. The figure displays the inverse-optimum Beveridge elasticity in the United States, 1951--2019. The figure also displays the calibrated Beveridge elasticity as a benchmark.
%
%% Output
%
% * Figure 9A is saved as figure9A.pdf.
% * The underlying data are saved in figure9A.xlsx.
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

% Compute labor-market tightness
theta= v./u;

%% ---  Get sufficient statistics ---

% Get calibrated Beveridge elasticity and its 95% confidence interval
[epsilon, epsilonLow, epsilonHigh] = getBeveridgeElasticity();

% Input the social value of nonwork calibrated in section 5.2
zeta = 0.26;

% Input the recruiting cost calibrated in section 5.3
kappa = 0.92; 

%% --- Compute inverse-optimum Beveridge elasticity ---

epsilonStar = computeBeveridgeInverse(theta, zeta, kappa);

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

% Paint 95% confidence interval for calibrated Beveridge elasticity
a = area(timeline, [epsilonLow, epsilonHigh - epsilonLow], 'LineStyle', 'none');
a(1).FaceAlpha = 0;
a(2).FaceAlpha = 0.2;
a(2).FaceColor = purple;
plot(timeline, epsilonLow, thinPurpleSetting{:})
plot(timeline, epsilonHigh, thinPurpleSetting{:})

% Plot calibrated Beveridge elasticity
plot(timeline, epsilon, purpleSetting{:})

% Plot inverse-optimum Beveridge elasticity
plot(timeline, epsilonStar, pinkSetting{:})

% Populate axes
set(gca, xSetting{:})
set(gca, 'yTick', [0:2:6], 'yLim', [0,6])
ylabel('Beveridge elasticity')

% Print figure
print('-dpdf', 'figure9A.pdf')

%% --- Save results ---

file = 'figure9A.xlsx';
sheet = 'Figure 9A';

% Write header
header = {'Date', 'Inverse-optimum Beveridge elasticity', 'Calibrated Beveridge elasticity', 'Low-end calibration of Beveridge elasticity', 'High-end calibration of Beveridge elasticity'};
writecell(header, file, 'Sheet', sheet, 'WriteMode', 'replacefile')

% Write results
result = [timeline, epsilonStar, epsilon, epsilonLow, epsilonHigh];
writematrix(result, file, 'Sheet', sheet, 'WriteMode', 'append')