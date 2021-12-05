%% figure5.m
% 
% Produce figures 5A, 5B, 5C, 5D, 5E, and 5F
%
%% Description
%
% This script produces figures 5A, 5B, 5C, 5D, 5E, and 5F. The figures display the 6 branches of the Beveridge curve in the United States, 1951--2019. The branches are delineated by structural breaks, whose number and dates are estimated by the Bai-Perron algorithm. The figures also display the 95% confidence intervals for the break dates.
%
%% Output
%
% * Figure 5A is saved as figure5A.pdf.
% * Figure 5B is saved as figure5B.pdf.
% * Figure 5C is saved as figure5C.pdf.
% * Figure 5D is saved as figure5D.pdf.
% * Figure 5E is saved as figure5E.pdf.
% * Figure 5F is saved as figure5F.pdf.
% * The underlying data are saved in figure5.xlsx.
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

% Get Beveridge-curve break dates
[T, nT, lowT, highT] = getBreakDate();

% Get recessions dates
[startRecession, endRecession, nRecession] = getRecessionDate();

%% --- Construct branches of the Beveridge curve for display ---

% Construct start and end dates for branches
nBranch = nT + 1;
startBranch = [1; T + 1];
endBranch = [T; nQuarter];

% Get unemployment & vacancy on each branch
for iBranch = 1 : nBranch 
	uBranch{iBranch} = u(startBranch(iBranch) : endBranch(iBranch));
	vBranch{iBranch} = v(startBranch(iBranch) : endBranch(iBranch));
end

% Get unemployment & vacancy on each confidence interval
for iT = 1 : nT
	uCi{iT} = u(lowT(iT) : highT(iT));
	vCi{iT} = v(lowT(iT) : highT(iT));
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

	% Paint confidence interval of end date
	if iBranch <= nT
		plot(log(uCi{iBranch}), log(vCi{iBranch}), transparentSetting{:})
	end

	% Paint confidence interval of start date
	if iBranch>1
		plot(log(uCi{iBranch-1}), log(vCi{iBranch-1}), transparentSetting{:})
	end

	% Plot branch of Beveridge curve
	plot(log(uBranch{iBranch}), log(vBranch{iBranch}), purpleSetting{:})

	% Populate axes
	set(gca, 'xLim', [-3.7,-2.2], 'xTick', [-3.7:0.3:-2.2])
	set(gca, 'yLim', [-4.2,-3], 'yTick', [-4.2:0.3:-3])
	xlabel('Log unemployment rate')
	ylabel('Log vacancy rate')

	% Print figure
	set(gca, 'Position', get(gca,'Position') + [0.01,0.01,0,0]); 
	panel = {'A', 'B', 'C', 'D', 'E', 'F'};
	print('-dpdf', ['figure5', panel{iBranch}, '.pdf'])

end

%% --- Save results ---

file = 'figure5.xlsx';

%% Save structural breaks

sheet = 'Structural breaks';

% Write header
header = {'Break date', 'Low end of 95% confidence interval for break dates', 'High end of 95% confidence interval for break dates'};
writecell(header, file, 'Sheet', sheet, 'WriteMode', 'replacefile')

% Translate indices for break dates into years
result = [T, lowT, highT];
result = ((result - 1) ./ 4) + 1951;

% Write results
writematrix(result, file, 'Sheet', sheet, 'WriteMode', 'append')

%% Save each Beveridge-curve branch on a different sheet

sheet = {'Figure 5A', 'Figure 5B', 'Figure 5C', 'Figure 5D', 'Figure 5E', 'Figure 5F'};
nSheet = length(sheet);

for iSheet = 1 : nSheet

	% Write header
	header = {'Log unemployment rate', 'Log vacancy rate'};
	writecell(header, file, 'Sheet', sheet{iSheet})

	% Write results
	result = [log(uBranch{iSheet}), log(vBranch{iSheet})];
	writematrix(result, file, 'Sheet', sheet{iSheet}, 'WriteMode', 'append')

end
