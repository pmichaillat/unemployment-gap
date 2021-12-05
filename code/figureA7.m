%% figureA7.m
% 
% Produce figure A7
%
%% Description
%
% This script produces figure A7. The figure displays the Hosiosian efficient unemployment rate in the United States, 1951--2019. This efficient unemployment rate accounts for the dynamics of unemployment present in the DMP model. As a benchmark, the figure also displays the Beveridgean efficient unemployment rate. This efficient unemployment rate assumes that unemployment in the DMP model is always on the Beveridge curve.
%
%% Output
%
% * Figure A7 is saved as figureA7.pdf.
% * The underlying data are saved in figureA7.xlsx.
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

% Get job-finding rate
f = measureJobFinding('quarterly');

% Get job-separation rate 
lambda = measureJobSeparation('quarterly');

%% ---  Get sufficient statistics ---

% Get Beveridge elasticity
epsilon = getBeveridgeElasticity();

% Input the social value of nonwork estimated in section 5.2
zeta = 0.26;

% Input the recruiting cost estimated in section 5.3
kappa = 0.92; 

%% --- Calibrate parameters of DMP model ---

% Calibrate matching elasticity
eta = computeMatchingElasticity(epsilon, u);

% Calibrate relative productivity of unemployed workers
z = zeta;

% Calibrate recruiting cost
c = kappa;

% Calibrate separation-efficacy ratio
lambdaOmega = computeSeparationEfficacy(eta, u, theta);

% Calibrate matching efficacy
omega = computeMatchingEfficacy(f, theta, eta);

% Calibrate discount rate as discussed in online appendix D
r = 0.012;

%% --- Compute Beveridgean efficient unemployment rate ---

% Reshape parameters to have a uniform size
z = repmat(z, size(eta));
c = repmat(c, size(eta));

% Compute efficient unemployment rate
uStarBeveridge = computeEfficiencyEndogenous(eta, z, c, lambdaOmega);

%% --- Compute Hosiosian efficient unemployment rate ---

% Reshape parameters to have a uniform size
r = repmat(r, size(eta));

% Compute efficient unemployment rate
uStarHosios = computeEfficiencyHosios(eta, z, c, lambda, omega, r, u(1));

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

% Plot Beveridgean efficient unemployment rate
plot(timeline, uStarBeveridge, pinkSetting{:})

% Plot Hosiosian efficient unemployment rate
plot(timeline, uStarHosios, orangeSetting{:})

% Populate axes
set(gca, xSetting{:})
set(gca, 'yLim', [0,0.06], 'yTick', [0:0.01:0.06], 'yTickLabel', ['0%';'1%';'2%';'3%';'4%';'5%';'6%'])
ylabel('Efficient unemployment rate')

% Print figure
print('-dpdf', 'figureA7.pdf')

%% --- Save results ---

file = 'figureA7.xlsx';
sheet = 'Figure A7';

% Write header
header = {'Date', 'Beveridgean efficient unemployment rate', 'Hosiosian efficient unemployment rate'};
writecell(header, file, 'Sheet', sheet, 'WriteMode', 'replacefile')

% Write results
result = [timeline, uStarBeveridge, uStarHosios];
writematrix(result, file, 'Sheet', sheet, 'WriteMode', 'append')