%% computeEfficientTightness
%
% Compute efficient labor-market tightness from sufficient-statistic formula 
%
%% Syntax
% 
%   thetaStar = computeEfficientTightness(epsilon, zeta, kappa)
%
%% Arguments
%
% * epsilon - scalar or n-by-1 column vector
% * zeta - scalar or n-by-1 column vector
% * kappa - scalar or n-by-1 column vector
% * thetaStar - scalar or n-by-1 column vector
%
%% Description
%
% This function computes the efficient labor-market tightness thetaStar using the sufficient-statistic formula in proposition 2 and three sufficient statistics: Beveridge elasticity epsilon, social value of nonwork zeta, and recruiting cost kappa.
%

function thetaStar = computeEfficientTightness(epsilon, zeta, kappa)

% Apply equation (4)
thetaStar = (1 - zeta) ./ (kappa .* epsilon); 
