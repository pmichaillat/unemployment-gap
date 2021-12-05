%% figureA5.m
% 
% Produce figure A5
%
%% Description
%
% This script produces figure A5. The figure displays the efficient unemployment rate in the United States, 1951--2019, when the Beveridge elasticity is endogenous as in the DMP model. As a benchmark, the figure also displays the efficient unemployment rate when the Beveridge elasticity is exogenous.
%
%% Output
%
% * Figure A5 is saved as figureA5.pdf.
% * The underlying data are saved in figureA5.xlsx.
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

%% --- Compute efficient unemployment rate with exogenous Beveridge elasticity ---

uStarExogenous = computeEfficientUnemployment(epsilon, zeta, kappa, u, v);

%% --- Calibrate parameters of DMP model ---

% Calibrate matching elasticity
eta = computeMatchingElasticity(epsilon, u);

% Calibrate relative productivity of unemployed workers
z = zeta;

% Calibrate recruiting cost
c = kappa;

% Calibrate separation-efficacy ratio
lambdaOmega = computeSeparationEfficacy(eta, u, theta);

%% --- Compute efficient unemployment rate with endogenous Beveridge elasticity ---

% Reshape parameters to have a uniform size
z = repmat(z, size(eta));
c = repmat(c, size(eta));

% Compute the efficient unemployment rate
uStarEndogenous = computeEfficiencyEndogenous(eta, z, c, lambdaOmega);

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

% Plot efficient unemployment rate with exogenous Beveridge elasticity
plot(timeline, uStarExogenous, pinkSetting{:})

% Plot efficient unemployment rate with endogenous Beveridge elasticity
plot(timeline, uStarEndogenous, orangeSetting{:})

% Populate axes
set(gca, xSetting{:})
set(gca, 'yLim', [0,0.06], 'yTick', [0:0.01:0.06], 'yTickLabel', ['0%';'1%';'2%';'3%';'4%';'5%';'6%'])
ylabel('Efficient unemployment rate')

% Print figure
print('-dpdf', 'figureA5.pdf')

%% --- Save results ---

file = 'figureA5.xlsx';
sheet = 'Figure A5';

% Write header
header = {'Date', 'Efficient unemployment rate with exogenous Beveridge elasticity', 'Efficient unemployment rate  with endogenous Beveridge elasticity'};
writecell(header, file, 'Sheet', sheet, 'WriteMode', 'replacefile')

% Write results
result = [timeline, uStarExogenous, uStarEndogenous];
writematrix(result, file, 'Sheet', sheet, 'WriteMode', 'append')