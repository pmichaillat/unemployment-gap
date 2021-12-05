%% computeUnemploymentGap
%
% Compute unemployment gap from sufficient-statistic formula 
%
%% Syntax
% 
%   uGap = computeUnemploymentGap(epsilon,zeta,kappa,u,v)
%
%% Arguments
%
% * epsilon - scalar or n-by-1 column vector
% * zeta - scalar or n-by-1 column vector
% * kappa - scalar or n-by-1 column vector
% * u - scalar or n-by-1 column vector
% * v - scalar or n-by-1 column vector
% * uGap - scalar or n-by-1 column vector
%
%% Description
%
% This function computes the unemployment gap uGap using the sufficient-statistic formula in proposition 3, the current unemployment rate u and vacancy rate v, and three sufficient statistics: Beveridge elasticity epsilon, social value of nonwork zeta, and recruiting cost kappa.
%

function uGap = computeUnemploymentGap(epsilon, zeta, kappa, u, v)

% Apply equation (5)
uGap = u - ((kappa .* epsilon) ./ (1 - zeta) .* (v .* u.^epsilon)).^(1./(1 + epsilon));