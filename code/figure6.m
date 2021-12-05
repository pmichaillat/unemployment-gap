%% figure6.m
% 
% Produce figure 6
%
%% Description
%
% This script produces figure 6. The figure displays the Beveridge elasticity in the United States, 1951--2019. The figure also displays the 95% confidence interval for the Beveridge elasticity.
%
%% Output
%
% * Figure 6 is saved as figure6.pdf.
% * The underlying data are saved in figure6.xlsx.
%

close all
clear
clc

%% --- Get data ---

% Get timeline
[timeline, nQuarter] = getTimeline();

% Get recessions dates
[startRecession, endRecession, nRecession] = getRecessionDate();

% Get Beveridge elasticity
[epsilon, epsilonLow, epsilonHigh] = getBeveridgeElasticity();

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

% Paint confidence interval
a = area(timeline, [epsilonLow, epsilonHigh - epsilonLow], 'LineStyle', 'none');
a(1).FaceAlpha = 0;
a(2).FaceAlpha = 0.2;
a(2).FaceColor = purple;
plot(timeline, epsilonLow, thinPurpleSetting{:})
plot(timeline, epsilonHigh, thinPurpleSetting{:})

% Plot elasticity
plot(timeline, epsilon, purpleSetting{:})

% Populate axes
set(gca, xSetting{:})
set(gca, 'yLim', [0,1.5], 'yTick', [0:0.3:1.5])
ylabel('Beveridge elasticity')

% Print figure
print('-dpdf', 'figure6.pdf')

%% --- Save results ---

file = 'figure6.xlsx';
sheet = 'Figure 6';

% Write header
header = {'Date', 'Beveridge elasticity', 'Low end of 95% confidence interval for Beveridge elasticity', 'High end of 95% confidence interval for Beveridge elasticity'};
writecell(header, file, 'Sheet', sheet, 'WriteMode', 'replacefile')

% Write results
result = [timeline, epsilon, epsilonLow, epsilonHigh];
writematrix(result, file, 'Sheet', sheet, 'WriteMode', 'append')