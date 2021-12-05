%% figureA9.m
% 
% Produce figure A9
%
%% Description
%
% This script produces figure A9. The figure displays the efficient unemployment rate in the United States, 1951--2019, when the social value of nonwork fluctuates in response to productivity fluctuations as in some versions of the DMP model. This efficient unemployment rate is derived in online appendix E. As a benchmark, the figure also displays the efficient unemployment rate when the social value of nonwork remains constant.
%
%% Output
%
% * Figure A9 is saved as figureA9.pdf.
% * The underlying data are saved in figureA9.xlsx.
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

% Get labor productivity
p = getLaborProductivity();

% Detrend labor productivity
[pBar, pHat] = hpfilter(log(p), 1600);

% Convert detrended productivity from log to level
pHat = exp(pHat);

%% ---  Get sufficient statistics ---

% Get Beveridge elasticity
epsilon = getBeveridgeElasticity();

% Input the average social value of nonwork estimated in section 5.2
z = 0.26;

% Compute the fluctuating social value of nonwork given on p. 13 of online appendix
zeta = z ./ pHat;

% Input the recruiting cost estimated in section 5.3
kappa = 0.92; 

%% --- Compute efficient unemployment rates ---

% With fluctuating social value of nonwork
uStarFluctuating = computeEfficientUnemployment(epsilon, zeta, kappa, u, v);

% With constant social value of nonwork
uStarConstant = computeEfficientUnemployment(epsilon, z, kappa, u, v);

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

% Plot efficient unemployment rate with constant social value of nonwork
plot(timeline, uStarConstant, pinkSetting{:})

% Plot efficient unemployment rate with fluctuating social value of nonwork
plot(timeline, uStarFluctuating, orangeSetting{:})

% Populate axes
set(gca, xSetting{:})
set(gca, 'yLim', [0,0.06], 'yTick', [0:0.01:0.06], 'yTickLabel', ['0%';'1%';'2%';'3%';'4%';'5%';'6%'])
ylabel('Efficient unemployment rate')

% Print figure
print('-dpdf', 'figureA9.pdf')

%% --- Save results ---

file = 'figureA9.xlsx';
sheet = 'Figure A9';

% Write header
header = {'Date', 'Efficient unemployment rate with constant social value of nonwork', 'Efficient unemployment rate  with fluctuating social value of nonwork'};
writecell(header, file, 'Sheet', sheet, 'WriteMode', 'replacefile')

% Write results
result = [timeline, uStarConstant, uStarFluctuating];
writematrix(result, file, 'Sheet', sheet, 'WriteMode', 'append')