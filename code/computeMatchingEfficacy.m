%% computeMatchingElasticity
%
% Compute matching efficacy in DMP model
%
%% Syntax
% 
%   omega = computeMatchingEfficacy(f, theta, eta)
%
%% Arguments
%
% * f - scalar or n-by-1 column vector
% * theta - scalar or n-by-1 column vector
% * eta - scalar or n-by-1 column vector
% * omega - scalar or n-by-1 column vector
%
%% Description
%
% This function computes the matching efficacy omega in a DMP model from the job-finding rate f, the labor-market tightness theta, and the matching elasticity eta. The matching efficacy is derived in online appendix D.
%

function omega = computeMatchingEfficacy(f, theta, eta)

% Apply equation (A15)
omega= f ./ theta.^(1 - eta);