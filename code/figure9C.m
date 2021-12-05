%% figure9C.m
% 
% Produce figure 9C
%
%% Description
%
% This script produces figure 9C. The figure displays the inverse-optimum recruiting cost in the United States, 1951--2019. The figure also displays the calibrated recruiting cost as a benchmark.
%
%% Output
%
% * Figure 9C is saved as figure9C.pdf.
% * The underlying data are saved in figure9C.xlsx.
%

close all
clear
clc

%% --- Get data ---

% Get timeline
[timeline, nQuarter] = getTimeline();

% Get recessions dates
[startRecession, endRecession, nRecession] = getRecessionDate();

% Get unemployment rate
u = getUnemploymentRate();

% Get vacancy rate
v = getVacancyRate();

% Compute labor-market tightness
theta= v./u;

%% ---  Get sufficient statistics ---

% Get calibrated Beveridge elasticity
epsilon = getBeveridgeElasticity();

% Input the social value of nonwork calibrated in section 5.2
zeta = 0.26;

% Input the recruiting cost calibrated in section 5.3, and 2/3 and 4/3 of this value
kappa = 0.92; 
kappaLow = (2/3).*kappa;
kappaHigh = (4/3).*kappa;

%% --- Compute inverse-optimum recruiting cost ---

kappaStar = computeRecruitingInverse(theta, epsilon, zeta);

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

% Resize calibrated recruiting cost
kappa = kappa .* ones(nQuarter,1);
kappaLow = kappaLow .* ones(nQuarter,1);
kappaHigh = kappaHigh .* ones(nQuarter,1);

% Paint plausible interval for calibrated recruiting cost
a = area(timeline, [kappaLow, kappaHigh - kappaLow], 'LineStyle', 'none');
a(1).FaceAlpha = 0;
a(2).FaceAlpha = 0.2;
a(2).FaceColor = purple;
plot(timeline, kappaLow, thinPurpleSetting{:})
plot(timeline, kappaHigh, thinPurpleSetting{:})

% Plot calibrated recruiting cost
plot(timeline, kappa, purpleSetting{:})

% Plot inverse-optimum recruiting cost
plot(timeline, kappaStar, pinkSetting{:})

% Populate axes
set(gca, xSetting{:})
set(gca, 'yTick', [0:2:6], 'yLim', [0,6])
ylabel('Recruiting cost')

% Print figure
print('-dpdf', 'figure9C.pdf')

%% --- Save results ---

file = 'figure9C.xlsx';
sheet = 'Figure 9C';

% Write header
header = {'Date', 'Inverse-optimum recruiting cost', 'Calibrated recruiting cost', 'Low-end calibration of recruiting cost', 'High-end calibration of recruiting cost'};
writecell(header, file, 'Sheet', sheet, 'WriteMode', 'replacefile')

% Write results
result = [timeline, kappaStar, kappa, kappaLow, kappaHigh];
writematrix(result, file, 'Sheet', sheet, 'WriteMode', 'append')