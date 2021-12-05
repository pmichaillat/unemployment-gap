%% computeBeveridgeanUnemployment
%
% Compute Beveridgean unemployment rate in DMP model
%
%% Syntax
% 
%   ub = computeBeveridgeanUnemployment(f, lambda)
%
%% Arguments
%
% * f - scalar or n-by-1 column vector
% * lambda - scalar or n-by-1 column vector
% * ub - scalar or n-by-1 column vector
%
%% Description
%
% This function computes the Beveridgean unemployment rate ub in a DMP model from the job-finding rate f and the job-separation rate lambda. The derivation of the Beveridgean unemployment rate is in section 4.1.
%

function ub = computeBeveridgeanUnemployment(f, lambda)

% Apply equation (9)
ub = lambda ./ (lambda + f);