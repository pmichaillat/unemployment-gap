%% computeEfficiencyEndogenous
%
% Compute efficient allocation in DMP model using sufficient-statistic formula with endogeous Beveridge elasticity
%
%% Syntax
% 
%   [uStar, thetaStar] = computeEfficiencyEndogenous(eta, z, c, lambdaOmega)
%
%% Arguments
%
% * eta - n-by-1 column vector
% * z - n-by-1 column vector
% * c - n-by-1 column vector
% * lambdaOmega - n-by-1 column vector
% * uStar - n-by-1 column vector
% * thetaStar - n-by-1 column vector
%
%% Description
%
% This function computes the efficient unemployment rate uStar and efficient labor-market tightness thetaStar in a DMP model using the sufficient-statistic formula in proposition 2 and accounting for the endogeneity of the Beveridge elasticity. This efficient unemployment rate and efficient tightness are derived in online appendix C. 
%
% The computation requires to input the values of the following parameters of the DMP model:
% * eta - matching elasticity
% * z - relative productivity of unemployed workers
% * c - recruiting cost
% * lambdaOmega - separation-efficiency ratio
%

function [uStar, thetaStar] = computeEfficiencyEndogenous(eta, z, c, lambdaOmega)

%% --- Compute efficient labor-market tightness ---

% Setup grids to solve for the efficient tightness each period
thetaRange = [0.01:0.0001:3];
[etaGrid,thetaGrid] = ndgrid(eta,thetaRange);

% Reshape parameters as grids
col = size(thetaGrid,2);
zGrid = repmat(z, 1, col);
cGrid = repmat(c, 1, col);
lambdaOmegaGrid = repmat(lambdaOmega, 1, col);

% Evaluate the distance between the left-hand and right-hand sides of equation (A10) on the grid
distance = abs(etaGrid .* thetaGrid + lambdaOmegaGrid .* (thetaGrid.^etaGrid) - ((1 - etaGrid) .* (1 - zGrid) ./ cGrid));

% Each month, find the tightness that minimizes the distance: this is the efficient tightness
[M, I] = min(distance, [], 2);
thetaStar = thetaRange(I)';

%% --- Compute efficient unemployment rate ---

% Apply equation (A11)
uStar = lambdaOmega ./ (lambdaOmega + (thetaStar.^(1-eta)));