%% computeEfficiencyHosios
%
% Compute efficient allocation in DMP model using Hosios condition
%
%% Syntax
% 
%   [uStar, thetaStar] = computeEfficiencyHosios(eta, z, c, lambda, omega, r, u0)
%
%% Arguments
%
% * eta - n-by-1 column vector
% * z - n-by-1 column vector
% * c - n-by-1 column vector
% * lambda - n-by-1 column vector
% * omega - n-by-1 column vector
% * r - n-by-1 column vector
% * u0 - scalar
% * uStar - n-by-1 column vector
% * thetaStar - n-by-1 column vector
%
%% Description
%
% This function computes the efficient unemployment rate uStar and efficient labor-market tightness thetaStar in a DMP model using the Hosios condition. This efficient unemployment rate and efficient tightness are derived in online appendix D. 
%
% The computation requires to input the values of the parameters of the DMP model at each of the n periods considered:
% * eta - matching elasticity
% * z - relative productivity of unemployed workers
% * c - recruiting cost
% * lambda - job-separation rate
% * omega - matching efficacy
% * r - discount rate
%
% The computation also requires an initial value u0 for the efficient unemployment rate.
%

function [uStar, thetaStar] = computeEfficiencyHosios(eta, z, c, lambda, omega, r, u0)

%% --- Compute efficient labor-market tightness ---

% Setup grids to solve for the efficient tightness at each period
thetaRange = [0.01:0.0001:3];
[etaGrid,thetaGrid] = ndgrid(eta,thetaRange);

% Reshape parameters as grids
[row, col] = size(thetaGrid);
zGrid = repmat(z, 1, col);
cGrid = repmat(c, 1, col);
lambdaGrid = repmat(lambda, 1, col);
omegaGrid = repmat(omega, 1, col);
rGrid = repmat(r, 1, col);

% Evaluate the distance between the left-hand and right-hand sides of equation (A10) on the grid
distance = abs(etaGrid .* thetaGrid + ((lambdaGrid + rGrid) .* (thetaGrid.^etaGrid) ./ omegaGrid) - ((1 - etaGrid) .* (1 - zGrid) ./ cGrid));

% Each period, find the tightness that minimizes the distance: this is the efficient tightness
[M, I] = min(distance, [], 2);
thetaStar = thetaRange(I)';

%% --- Compute efficient unemployment rate ---

% Compute efficient job-finding rate
fStar = omega .* (thetaStar.^(1 - eta));

% Compute efficient Beveridgean unemployment
ubStar = computeBeveridgeanUnemployment(fStar, lambda);

% Initialize the efficient unemployment rate at u0
uStar(1,1) = u0;

% Apply equation (A14) recursively to compute the efficient unemployment rate each period
for t = 1 : (row - 1)
	uStar(t+1,1) = ubStar(t) + (uStar(t,1) - ubStar(t)) .* exp(-(lambda(t) + fStar(t)));
end