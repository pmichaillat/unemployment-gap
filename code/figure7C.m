%% figure7C.m
% 
% Produce figure 7C
%
%% Description
%
% This script produces figure 7C. The figure displays the unemployment gap in the United States, 1951--2019.
%
%% Output
%
% * Figure 7C is saved as figure7C.pdf.
% * The underlying data are saved in figure7C.xlsx.
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

% Input social value of nonwork
zeta = 0.26;

% Input recruiting cost
kappa = 0.92; 

%% --- Compute unemployment gap ---

uGap = computeUnemploymentGap(epsilon, zeta, kappa, u, v);

%% --- Format figure & plot ---

formatFigure
formatPlot

%% --- Produce figure  ---

figure(1)
clf
hold on

% Paint recession areas
for iRecession = 1 : nRecession
	area([startRecession(iRecession), endRecession(iRecession)], [2,2], -1, areaSetting{:});
end

% Plot unemployment gap
plot(timeline, uGap, purpleSetting{:})

% Populate axes
set(gca, xSetting{:})
set(gca, 'yLim', [-0.02,0.08], 'yTick', [-0.02:0.02:0.08], 'yTickLabel', ['-2';' 0';' 2';' 4';' 6';' 8'])
ylabel('Unemployment gap (percentage points)')

% Print figure
print('-dpdf', 'figure7C.pdf')


%% --- Save results ---

file = 'figure7C.xlsx';
sheet = 'Figure 7C';

% Write header
header = {'Date', 'Unemployment gap'};
writecell(header, file, 'Sheet', sheet, 'WriteMode', 'replacefile')

% Write results
result = [timeline, uGap];
writematrix(result, file, 'Sheet', sheet, 'WriteMode', 'append')