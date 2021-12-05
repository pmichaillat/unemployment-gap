%% computeMatchingElasticity
%
% Compute matching elasticity in DMP model
%
%% Syntax
% 
%   eta = computeMatchingElasticity(epsilon, u)
%
%% Arguments
%
% * epsilon - scalar or n-by-1 column vector
% * u - scalar or n-by-1 column vector
% * eta - scalar or n-by-1 column vector
%
%% Description
%
% This function computes the matching elasticity eta in a DMP model from the Beveridge elasticity epsilon and the unemployment rate u. The matching elasticity is derived in online appendix C.
%

function eta = computeMatchingElasticity(epsilon, u)

% Apply equation (A12)
eta = (epsilon -  (u./(1 - u))) ./ (1 + epsilon);