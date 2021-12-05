%% figure9B.m
% 
% Produce figure 9B
%
%% Description
%
% This script produces figure 9B. The figure displays the inverse-optimum social value of nonwork in the United States, 1951--2019. The figure also displays the calibrated social value of nonwork as a benchmark.
%
%% Output
%
% * Figure 9B is saved as figure9B.pdf.
% * The underlying data are saved in figure9B.xlsx.
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

% Input the midpoint, low-end, and high-end calibrations of the social value of nonwork from section 5.2
zeta = 0.26;
zetaLow = 0.03;
zetaHigh = 0.49;

% Input the recruiting cost calibrated in section 5.3
kappa = 0.92; 

%% --- Compute inverse-optimum social value of nonwork ---

zetaStar = computeNonworkInverse(theta, epsilon, kappa);

%% --- Format figure & plot ---

formatFigure
formatPlot

%% --- Produce figure ---

figure(1)
clf
hold on

% Paint recession areas
for iRecession = 1 : nRecession
	area([startRecession(iRecession), endRecession(iRecession)], [10,10], -10, areaSetting{:});
end

% Resize calibrated social value of nonwork
zeta = zeta .* ones(nQuarter,1);
zetaLow = zetaLow .* ones(nQuarter,1);
zetaHigh = zetaHigh .* ones(nQuarter,1);

% Paint plausible interval for calibrated social value of nonwork
a = area(timeline, [zetaLow, zetaHigh - zetaLow], 'LineStyle', 'none');
a(1).FaceAlpha = 0;
a(2).FaceAlpha = 0.2;
a(2).FaceColor = purple;
plot(timeline, zetaLow, thinPurpleSetting{:})
plot(timeline, zetaHigh, thinPurpleSetting{:})

% Plot calibrated social value of nonwork
plot(timeline, zeta, purpleSetting{:})

% Plot inverse-optimum social value of nonwork
plot(timeline, zetaStar, pinkSetting{:})

% Populate axes
set(gca, xSetting{:})
set(gca, 'yTick', [-0.5:0.5:1], 'yLim', [-0.5,1])
ylabel('Social value of nonwork')

% Print figure
print('-dpdf', 'figure9B.pdf')

%% --- Save results ---

file = 'figure9B.xlsx';
sheet = 'Figure 9B';

% Write header
header = {'Date', 'Inverse-optimum social value of nonwork', 'Calibrated social value of nonwork', 'Low-end calibration of social value of nonwork', 'High-end calibration of social value of nonwork'};
writecell(header, file, 'Sheet', sheet, 'WriteMode', 'replacefile')

% Write results
result = [timeline, zetaStar, zeta, zetaLow, zetaHigh];
writematrix(result, file, 'Sheet', sheet, 'WriteMode', 'append')