function [mBIC, mLWZ]=order(ssrzero,globl,bigt,m,q)

% Determination of the order using BIC and the criterion of Liu, Wu and
% Zidek

glob=zeros(m+1,1);
glob(1,1)=ssrzero;
glob(2:m+1,1)=globl;

bic=zeros(m+1,1);
lwz=zeros(m+1,1);

for i= 1:m+1
    bic(i,1)=log(glob(i,1)/bigt)+log(bigt)*(i-1)*(q+1)/bigt;
    lwz(i,1)=log(glob(i,1)/(bigt-i*q-i+1))...
        +((i-1)*(q+1)*.299*(log(bigt))^2.1)/bigt;
    
        disp(['With ' num2str(i-1) ' breaks: ']);
        disp(['BIC= ' num2str(bic(i,1))]) ;
        disp(['LWZ= ' num2str(lwz(i,1))]);

end
        

[dummy mbic]=min(bic);
[dummy mlwz]=min(lwz);

disp(['The number of breaks chosen by BIC is : ' num2str(mbic-1)]);
disp(['The number of breaks chosen by LWZ is : ' num2str(mlwz-1)]);

  mBIC=mbic-1;
  mLWZ=mlwz-1;


