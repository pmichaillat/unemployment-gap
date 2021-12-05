%% computeNonworkInverse
%
% Compute inverse-optimum social value of nonwork from sufficient-statistic formula 
%
%% Syntax
% 
%   zetaStar = computeNonworkInverse(theta, epsilon, kappa)
%
%% Arguments
%
% * theta - scalar or n-by-1 column vector
% * epsilon - scalar or n-by-1 column vector
% * kappa - scalar or n-by-1 column vector
% * zetaStar - scalar or n-by-1 column vector
%
%% Description
%
% This function computes the inverse-optimum social value of nonwork zetaStar using the sufficient-statistic formula in proposition 2, the current labor-market tightness theta, and two sufficient statistics: Beveridge elasticity epsilon and recruiting cost kappa.
%

function zetaStar = computeNonworkInverse(theta, epsilon, kappa)

% Apply equation (18)
zetaStar = 1 - (kappa .* epsilon .* theta);