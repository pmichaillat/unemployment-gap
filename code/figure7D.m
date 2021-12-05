%% figure7D.m
% 
% Produce figure 7D
%
%% Description
%
% This script produces figure 7D. The figure displays the efficient unemployment rate in the United States, 1951--2019, and compares it to other unemployment rates used to construct unemployment gaps.
%
%% Output
%
% * Figure 7D is saved as figure7D.pdf.
% * The underlying data are saved in figure7D.xlsx.
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

% Get natural rate of unemployment
[uNatural,timelineNatural] = getNaturalUnemployment();

% Get trend of unemployment rate
[uTrend,timelineTrend] = getTrendUnemployment();

% Get NAIRU
[uNairu,timelineNairu] = getNairu();

%% ---  Get sufficient statistics ---

% Get Beveridge elasticity
epsilon = getBeveridgeElasticity();

% Input social value of nonwork
zeta = 0.26;

% Input recruiting cost
kappa = 0.92; 

%% --- Compute efficient unemployment rate ---

uStar = computeEfficientUnemployment(epsilon, zeta, kappa, u, v);

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

%% plot alternative unemployment rates
plot(timelineNatural, uNatural, '--', 'Color', green, 'LineWidth', 3)
plot(timelineTrend, uTrend, ':','Color', black, 'LineWidth', 3)
plot(timelineNairu, uNairu, '-.','Color', orange, 'LineWidth', 3)

% Plot efficient unemployment rate
plot(timeline, uStar, pinkSetting{:})

% Populate axes
set(gca, xSetting{:})
set(gca, 'yLim', [0,0.1], 'yTick', [0:0.02:0.1], 'yTickLabel', [' 0%';' 2%';' 4%';' 6%';' 8%';'10%'])
ylabel('Unemployment rate')

% Print figure
print('-dpdf', 'figure7D.pdf')

%% --- Save results ---

file = 'figure7D.xlsx';
sheet = {'Efficient unemployment rate'; 'Natural unemployment rate'; 'Trend unemployment rate'; 'NAIRU'};
nSheet = length(sheet);
header(1:4,1) = {'Date'} ;
header(1:4,2) = sheet;			 
result = 	{[timeline, uStar];
			[timelineNatural, uNatural];
			[timelineTrend, uTrend];
			[timelineNairu, uNairu]};			 

for iSheet = 1 : nSheet

	% Write header
	if iSheet == 1
		writecell(header(iSheet,:), file, 'Sheet', sheet{iSheet}, 'WriteMode', 'replacefile')
	else
		writecell(header(iSheet,:), file, 'Sheet', sheet{iSheet})
	end

	% Write results
	writematrix(result{iSheet}, file, 'Sheet', sheet{iSheet}, 'WriteMode', 'append')
end