%% baiPerron.m
%
% Estimate the US Beveridge elasticity with the Bai-Perron algorithm
%
%% Description
%
% This script estimates the Beveridge elasticity for the United States, 1951--2019, by running the algorithm of Bai and Perron (1998, 2003) on log unemployment and vacancy rates. The algorithm is designed to estimate linear models with multiple structural breaks. 
%
% * The setup of the algorithm is described in section 5.1.
% * The algorithm determines the number of structural breaks in the Beveridge curve using several statistical tests.
% * The algorithm estimates the elasticity of each Beveridge curve branch by least-squares.
% *  The algorithm estimates the break dates by minimizing the sum of squared residuals. 
% * The algorithm also computes confidence intervals for the elasticities and break dates.
%
%% Output
%
% The estimation results are saved in baiperron.txt.
%
%% Original code
%
% * This script is based on the script brcode.m in the folder baiperron.
% * All the functions required in this script are contained in the folder baiperron.
% * The folder baiperron was downloaded from http://blogs.bu.edu/perron/files/2020/05/m-break-matlab.zip.
% 

close all
clear
clc
addpath('baiperron');

%% --- Get data ---

% Get unemployment rate
u = getUnemploymentRate();

% Get vacancy rate
v = getVacancyRate();

%% --- Set regressand and regressors ---

% Set the regressand
y = log(v);           

% Set the effective sample size
bigt = length(v); 

% Set the matrix of regressors with coefficients changing across regimes
z = [ones(bigt,1), log(u)];

% Set the number of regressors in z
q = size(z,2);             

% Set the matrix of regressors with coefficients fixed across regimes
x = [];

% Set the number of regressors in x 
p = size(x,2);  

%% --- Setup algorithm ---

% Set the value of the trimming parameter for the construction and the critical values of the supF-type tests (supF test, Dmax test, supF(l+1|l) test, and sequential  procedure). There are five options for eps1: 0.05, 0.10, 0.15, 0.20, and 0.25. 
eps1 = 0.15;   
        
% Set the maximum number of structural changes allowed. The maximal value of m is 10 for eps1 = 0.05, 8 for eps1 = 0.10, 5 for eps1 = 0.15, 3 for eps1 = 0.20, and 2 for eps1 = 0.25.
m = 5;

% Set the minimum branch length (h>q)
h = round(eps1*bigt); 

% Set to 1 to allow for heterogeneity & autocorrelation in the residuals, 0 otherwise.
robust = 1;      

% Set to 1 to apply AR(1) prewhitening prior to estimating the long-run covariance matrix.         
prewhit = 0;

% Set to 1 to allow for the variance of the residuals to be different across segments. If set to 0, the variance of the residuals is assumed constant across segments and constructed from the ful sample. This option applies to the construction of the F tests. This option is not used when robust = 1.  
hetvar = 1; 

% Set to 1 to allow different moment matrices of the regressors across segments. If set to 0, the same moment matrices are assumed for each segment  and estimated from the ful sample. This option applies for the construction of the F tests.
hetdat = 1;    

% Set to 1 to allow for long-run covariance matrix of the residuals to be different across segments. If set to 0, the long-run covariance matrix of the residuals is assumed identical across segments (the variance of the errors if robust = 0). This option applies to the construction of the confidence intervals for the break dates.
hetomega = 1; 

% Set to 1 to allow different moment matrices of the data across segments. If set to 0, the moment matrix of the data is assumed identical across segments. This option applies to the construction of the confidence intervals for the break dates.
hetq = 1;

%% --- Choose algorithm output ---

% Set to 1 to obtain global minimizers
doglobal = 1;

% Set to 1 to construct the supF, UDmax, and WDmax tests (doglobal must be set to 1 to run this procedure)
dotest = 1;               

% Set to 1 to construct the supF(l+1|l) tests where under the null the l breaks are obtained using global minimizers (doglobal must be set to 1 to run this procedure)
dospflp1 = 0;

% Set to 1 to select the number of breaks using information criteria (doglobal must be set to 1 to run this procedure)
doorder = 1;               

% Set to 1 to estimate the breaks sequentialy and estimate the number of breaks using supF(l+1|l) test
dosequa = 0;   

% Set to 1 to modify the break dates obtained from the sequential method using the repartition method of Bai (1995), estimating breaks one at a time. This is needed for the confidence intervals obtained with estimrep below to be valid.
dorepart = 0;

% Set to 1 to estimate the model with the number of breaks selected by BIC
estimbic = 1;              

% Set to 1 to estimate the model with the number of breaks selected by LWZ
estimlwz = 1;

% Set to 1 to estimate the model with the number of breaks selected using the sequential procedure              
estimseq = 0;

% Set to 1 to estimate the model with the breaks selected using the repartition method
estimrep = 0;              

% Set to 1 to estimate the model with a number of breaks equal to fixn
estimfix = 0;             
fixn = 0;

%% --- Additional, unused options ---

% The following options only apply to partial structural change models (p>0). They are not used here but need to be setup to default values.
fixb = 0;
betaini = 0;
maxi = 20;
printd = 1;
eps = 0.0001; 

%% --- Run the Bai-Perron algorithm ---

% Prepare to save algorithm results
diaryFile = 'baiperron.txt';
if exist(diaryFile, 'file'); delete(diaryFile); end
diary(diaryFile)

% Run algorithm
pbreak(bigt,y,z,q,m,h,eps1,robust,prewhit,hetomega,hetq,doglobal,dotest,dospflp1,doorder,dosequa,dorepart,estimbic,estimlwz,estimseq,estimrep,estimfix,fixb,x,p,eps,maxi,betaini,printd,hetdat,hetvar,fixn)
