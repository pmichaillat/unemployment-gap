%% formatFigure.m
% 
% Format figures
%
%% Description
%
% This script formats figures by modifying the default properties of figures and axes.
% 

%% --- Properties for figures ---

set(groot,'defaultFigureUnits', 'inches')
set(groot,'defaultFigurePosition', [1,1,7.7779,5.8334]);
set(groot,'defaultFigurePaperPosition', [0, 0, 7.7779,5.8334]);
set(groot,'defaultFigurePaperSize', [7.7779,5.8334]);

%% --- Properties for axes ---

set(groot,'defaultAxesFontName','Helvetica')
set(groot,'defaultAxesFontSize',22)
set(groot,'defaultAxesLabelFontSizeMultiplier',1)
set(groot,'defaultAxesTitleFontSizeMultiplier',1)
set(groot,'defaultAxesTitleFontWeight','normal')
set(groot,'defaultAxesXColor','k')
set(groot,'defaultAxesYColor','k')
set(groot,'defaultAxesGridColor','k')
set(groot,'defaultAxesLineWidth',1)
set(groot,'defaultAxesYGrid','on')
set(groot,'defaultAxesXGrid','off')
set(groot, 'defaultAxesTickDirMode', 'manual')
set(groot,'defaultAxesTickLength',[0.01 0.025])
set(groot, 'defaultAxesTickDir', 'out')