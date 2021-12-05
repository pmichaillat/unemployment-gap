%% computeRecruitingInverse
%
% Compute inverse-optimum recruiting cost from sufficient-statistic formula 
%
%% Syntax
% 
%   kappaStar = computeRecruitingInverse(theta, epsilon, zeta)
%
%% Arguments
%
% * theta - scalar or n-by-1 column vector
% * epsilon - scalar or n-by-1 column vector
% * zeta - scalar or n-by-1 column vector
% * kappaStar - scalar or n-by-1 column vector
%
%% Description
%
% This function computes the inverse-optimum recruiting cost kappaStar using the sufficient-statistic formula in proposition 2, the current labor-market tightness theta, and two sufficient statistics: Beveridge elasticity epsilon and social value of nonwork zeta.
%

function kappaStar = computeRecruitingInverse(theta, epsilon, zeta)

% Apply equation (19)
kappaStar = (1 - zeta) ./ (epsilon .* theta);