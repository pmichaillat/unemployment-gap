%% computeSeparationEfficacy
%
% Compute separation-efficacy ratio in DMP model
%
%% Syntax
% 
%   lambdaOmega = computeSeparationEfficacy(eta, u, theta)
%
%% Arguments
%
% * eta - scalar or n-by-1 column vector
% * u - scalar or n-by-1 column vector
% * theta - scalar or n-by-1 column vector
% * lambdaOmega - scalar or n-by-1 column vector
%
%% Description
%
% This function computes the separation-efficacy ratio lambdaOmega in a DMP model from the matching elasticity eta, labor-market tightness theta, and unemployment rate u. The separation-efficacy ratio is derived in online appendix C.
%

function lambdaOmega = computeSeparationEfficacy(eta, u, theta)

% Apply equation on p. 9 of online appendix
lambdaOmega = u .* (theta.^(1 - eta)) ./ (1 - u);