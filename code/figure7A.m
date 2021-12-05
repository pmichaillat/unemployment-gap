%% figure7A.m
% 
% Produce figure 7A
%
%% Description
%
% This script produces figure 7A. The figure displays the efficient labor-market tightness in the United States, 1951--2019. The figure also displays the US labor-market tightness as a benchmark.
%
%% Output
%
% * Figure 7A is saved as figure7A.pdf.
% * The underlying data are saved in figure7A.xlsx.
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

% Get Beveridge elasticity
epsilon = getBeveridgeElasticity();

% Input the social value of nonwork estimated in section 5.2
zeta = 0.26;

% Input the recruiting cost estimated in section 5.3
kappa = 0.92; 

%% --- Compute efficient tightness ---

thetaStar = computeEfficientTightness(epsilon, zeta, kappa);

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

% Paint tightness gap
a = area(timeline, [thetaStar, max(theta - thetaStar,0), min(theta - thetaStar,0)], 'LineStyle', 'none');
a(1).FaceAlpha = 0;
a(2).FaceAlpha = 0.2;
a(3).FaceAlpha = 0.2;
a(2).FaceColor = pink;
a(3).FaceColor = purple;

% Plot actual tightness 
plot(timeline, theta, purpleSetting{:})

% Plot efficient tightness
plot(timeline, thetaStar, pinkSetting{:})

% Populate axes
set(gca, xSetting{:})
set(gca, 'yLim', [0,1.5], 'yTick', [0:0.3:1.5])
ylabel('Labor-market tightness')

% Print figure
print('-dpdf', 'figure7A.pdf')

%% --- Save results ---

file = 'figure7A.xlsx';
sheet = 'Figure 7A';

% Write header
header = {'Date', 'Labor-market tightness', 'Efficient labor-market tightness'};
writecell(header, file, 'Sheet', sheet, 'WriteMode', 'replacefile')

% Write results
result = [timeline, theta, thetaStar];
writematrix(result, file, 'Sheet', sheet, 'WriteMode', 'append')