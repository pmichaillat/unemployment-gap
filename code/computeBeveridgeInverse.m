%% computeBeveridgeInverse
%
% Compute inverse-optimum Beveridge elasticity from sufficient-statistic formula 
%
%% Syntax
% 
%   epsilonStar = computeBeveridgeInverse(theta,zeta,kappa)
%
%% Arguments
%
% * theta - scalar or n-by-1 column vector
% * zeta - scalar or n-by-1 column vector
% * kappa - scalar or n-by-1 column vector
% * epsilonStar - scalar or n-by-1 column vector
%
%% Description
%
% This function computes the inverse-optimum Beveridge elasticity epsilonStar using the sufficient-statistic formula in proposition 2, the current labor-market tightness theta, and two sufficient statistics: social value of nonwork zeta and recruiting cost kappa.
%

function epsilonStar = computeBeveridgeInverse(theta, zeta, kappa)

% Apply equation (17)
epsilonStar = (1 - zeta) ./ (kappa .* theta);