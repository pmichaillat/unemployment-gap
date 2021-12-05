%% formatPlot.m
% 
% Provide formatting settings for plots
%
%% Description
%
% This script provides formatting settings for plots. Each setting is contained in a cell array:
% 
% * areaSetting - formatting for recession areas
% * purpleSetting - formatting for regular purple line
% * pinkSetting - formatting for regular pink line
% * orangeSetting - formatting for regular orange line
% * graySetting - formatting for semi-thin gray line
% * transparentSetting - formatting for wide, transparent purple line
% * thinPurpleSetting - formatting for thin purple line
% * thinPinkSetting - formatting for thin pink line
% * thinOrangeSetting - formatting for thin orange line
% * xSetting - formatting of x-axis for quarterly series from 1951Q1 to 2019Q4
%
% The script also provides a color palette composed of purple, pink, black, gray, orange, green. Each color is specified in hexadecimal format (hex triplet) and encoded as a string.
%
%% Examples
%
%   plot(x, y, purpleSetting{:})
%   area(x, y, areaSetting{:})
%   plot(x, y, 'Color', purple)
%

%% --- Color palette ---

purple = '#7570b3';
pink = '#e7298a';
black = '#666666';
green = '#1b9e77';
orange = '#d95f02';
gray = '#c0c0c0';

%% --- Formatting settings for areas ---

areaSetting = 	{'FaceColor', 'LineStyle', 'FaceAlpha';
				'black', 'none', 0.15};

%% --- Formatting settings for lines ---

purpleSetting = {'Color', 'LineWidth';
				purple, 3};

pinkSetting = 	{'Color', 'LineWidth';
				pink, 3};

orangeSetting = {'Color', 'LineWidth';
				orange, 3};

graySetting = 	{'Color', 'LineWidth';
				gray, 1};

transparentSetting = 	{'Color', 'LineWidth';
						[0.459, 0.439, 0.702, 0.2], 12};

thinPurpleSetting = {'Color', 'LineWidth';
					purple, 0.5};

thinPinkSetting = 	{'Color', 'LineWidth';
					pink, 0.5};

thinOrangeSetting = 	{'Color', 'LineWidth';
						orange, 1};

%% --- Formatting settings for axes ---

xSetting = {'Xlim', 'XTick';
			[1951, 2019.75], [1951, 1970, 1985, 2000, 2019]};
