function estim(m,q,z,y,b,robust,prewhit,hetomega,hetq,x,p,hetdat,hetvar)

% This procedure estimates by OLS the model given the obtained break dates.
% It also computes and reports confidence intervals for the break dates.
% The method used depends on the specification for robust

if m==0
    
    disp('There are no breaks in this model and estimation is skipped')
else
    
    bigt=size(z,1);
    d=(m+1)*q+p;
    vdel=zeros(d,d);
    
    % Construct the Z_bar matrix. The diagonal partition of Z at the
    % estimated break dates.
    
    zbar=pzbar(z,m,b);
    
    % Estimation and printing
    
    if p==0
        reg=zbar;
    else
        reg=[x zbar];
    end
    
    OLS(y,reg,0);
    
    vdel=pvdel(y,z,m,q,bigt,b,prewhit,robust,x,p,1,hetdat,hetvar);
    
    disp('----------------------------------------------------')
    disp('Corrected standard errors for the coefficients')
    disp('----------------------------------------------------')
    
    for i=1:d
        disp(['The corrected standard errors for coefficient ' num2str(i) ' is: ' num2str(sqrt(vdel(i,i)))])
    end
    
    if robust==0 && hetdat==1 && hetdat==0
        disp('In thie case robust=0, hetdat=1 and hetvar=0, the "corrected" are the same')
        disp('as that of the printout except for a different small sample correction.')
    end
    
    % Confidence interval for the break dates
    
    bound=interval(y,z,zbar,b,q,m,robust,prewhit,hetomega,hetq,x,p);
    disp('--------------------------------------------------------')
    disp('Confidence intervals for the break dates')
    disp('--------------------------------------------------------')
    for i=1:m
        disp(['The 95% C.I. for the ' num2str(i) 'th break is: ' num2str(bound(i,1)) ' ' num2str(bound(i,2))])
        disp(['The 90% C.I. for the ' num2str(i) 'th break is: ' num2str(bound(i,3)) ' ' num2str(bound(i,4))])
    end
    disp('***********************************************************')
end