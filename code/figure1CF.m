%% figure1CF.m
% 
% Produce figures 1C, 1D, 1E, and 1F
%
%% Description
%
% This script produces figures 1C, 1D, 1E, and 1F. The figures display the Beveridge curve in the United States, 1951--2019. 
%
% The figures highlight four consecutive periods:
% * figure 1C - 1951--1969
% * figure 1D - 1970--1989
% * figure 1E - 1990--2009
% * figure 1F - 2010--2019
%
%% Output
%
% * Figure 1C is saved as figure1C.pdf.
% * Figure 1D is saved as figure1D.pdf.
% * Figure 1E is saved as figure1E.pdf.
% * Figure 1F is saved as figure1F.pdf.
% * The underlying data are saved in figure1CF.xlsx.
%

close all
clear
clc

%% --- Get data ---

% Get timeline
[timeline, nQuarter] = getTimeline();

% Get unemployment rate
u = getUnemploymentRate();

% Get vacancy rate
v = getVacancyRate();

% Get recessions dates
[startRecession, endRecession, nRecession] = getRecessionDate();

%% --- Construct branches of the Beveridge curve for display ---

% Pick break years
breaks = [1970; 1990; 2010];

% Translate break years into indices
breaks = ((breaks - 1951) .* 4) + 1;

% Construct start and end dates for branches
nBranch = length(breaks) + 1;
startBranch = [1; breaks];
endBranch = [breaks - 1; nQuarter];

% Get unemployment & vacancy on each branch
for iBranch = 1 : nBranch 
	uBranch{iBranch} = u(startBranch(iBranch) : endBranch(iBranch));
	vBranch{iBranch} = v(startBranch(iBranch) : endBranch(iBranch));
end

%% --- Format figure & plot ---

% Run default formatting scripts
formatFigure
formatPlot

% Adjust axes properties for scatter plots
set(groot, 'defaultAxesXGrid', 'on')
set(groot, 'defaultAxesTickLength', [0 0])

%% --- Produce one figure per branche of the Beveridge curve ---

for iBranch = 1 : nBranch

	figure(iBranch)
	clf
	hold on

	% Plot background Beveridge curve
	plot(log(u), log(v), graySetting{:})

	% Highlight current branch of Beveridge curve
	plot(log(uBranch{iBranch}), log(vBranch{iBranch}), purpleSetting{:})

	% Populate axes
	set(gca, 'xLim', [-3.7,-2.2], 'xTick', [-3.7:0.3:-2.2])
	set(gca, 'yLim', [-4.2,-3], 'yTick', [-4.2:0.3:-3])
	xlabel('Log unemployment rate')
	ylabel('Log vacancy rate')

	% Print figure
	set(gca,'Position',get(gca,'Position') + [0.01,0.01,0,0]); 
	panel = {'C', 'D', 'E', 'F'};
	print('-dpdf', ['figure1', panel{iBranch}, '.pdf'])

end

%% --- Save results ---

file = 'figure1CF.xlsx';
sheet = 'Figures 1C-1F';

% Write header
header = {'Date', 'Log unemployment rate', 'Log vacancy rate'};
writecell(header, file, 'Sheet', sheet, 'WriteMode', 'replacefile')

% Write results
result = [timeline, log(u), log(v)];
writematrix(result, file, 'Sheet', sheet, 'WriteMode', 'append')


