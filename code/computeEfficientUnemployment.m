%% computeEfficientUnemployment
%
% Compute efficient unemployment rate from sufficient-statistic formula 
%
%% Syntax
% 
%   uStar = computeEfficientUnemployment(epsilon, zeta, kappa, u, v)
%
%% Arguments
%
% * epsilon - scalar or n-by-1 column vector
% * zeta - scalar or n-by-1 column vector
% * kappa - scalar or n-by-1 column vector
% * u - scalar or n-by-1 column vector
% * v - scalar or n-by-1 column vector
% * uStar - scalar or n-by-1 column vector
%
%% Description
%
% This function computes the efficient unemployment rate uStar using the sufficient-statistic formula in proposition 3, the current unemployment rate u and vacancy rate v, and three sufficient statistics: Beveridge elasticity epsilon, social value of nonwork zeta, and recruiting cost kappa.
%

function uStar = computeEfficientUnemployment(epsilon, zeta, kappa, u, v)

% Apply equation (5)
uStar = (kappa.*epsilon.*v.*(u.^epsilon)./(1 - zeta)).^(1./(1 + epsilon));