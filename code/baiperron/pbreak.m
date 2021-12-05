function []=pbreak(bigt,y,z,q,m,h,eps1,robust,prewhit,hetomega,hetq,doglobal,dotest,dospflp1,doorder,dosequa,dorepart,estimbic,estimlwz,estimseq,estimrep,estimfix,fixb,x,p,eps,maxi,betaini,printd,hetdat,hetvar,fixn)

disp('The option chosen are:')
disp(['h = ' num2str(h)])
disp(['eps1 = ' num2str(eps1)])
disp(['hetdat = ' num2str(hetdat)])
disp(['hetvar = ' num2str(hetvar)])
disp(['hetomega = ' num2str(hetomega)])
disp(['hetq = ' num2str(hetq)])
disp(['robust = ' num2str(robust) ' (prewhit =' num2str(prewhit) ')'])
disp(['hetvar = ' num2str(hetvar)])
disp(['The maximum number of breaks is: ' num2str(m)])
disp('***********************************************************')

siglev=[10;5;2.5;1];

if doglobal==1
    
% The following calls the procedure to obtain the break dates and the associated sum of squared residuals for all numbers of breaks between 1 and m    
 disp('Output from the global optimization')
 disp('***********************************************************')
 
 if p==0
    [glob,datevec,bigvec]=dating(y,z,h,m,q,bigt);
 else
     disp('This is a partial structural change model and the following')
     disp('specifications were used:')
     disp(['The number of regressors with fixed coefficients, p: ' num2str(p)])
     disp(['Whether (1) or not (0) the initial values of beta are fixed: ' num2str(fixb)])
     disp(['If so, at the following values: ' num2str(betaini)])
     disp(['The convergence criterion is: ' num2str(eps)])
     disp(['Whether (1) or not (0) the iterations are printed: ' num2str(printd)])
     disp('----------------------')
    [glob,datevec,bigvec]=nldat(y,z,x,h,m,p,q,bigt,fixb,eps,maxi,betaini,printd);
 end
  
 for i=1:m
     disp(['The model with ' num2str(i) 'breaks has SSR : ' num2str(glob(i,1))])
     disp(['The dates of the breaks are: ' num2str(datevec(1:i,i)')])
 end
end

if dotest==1
  %The following calls the procedure to estimate and print various tests for the number of breaks. It also returns the UDmax and WDmax tests.
  disp('************************************')
  disp('Output from the testing procedures')
  disp('************************************')
  disp('a) supF tests against a fixed number of breaks')
  disp('-----------------------------------------')

  ftest=zeros(m,1);
  wftest=zeros(m,1);
     
  for i=1:m
     ftest(i,1)=pftest(y,z,i,q,bigt,datevec,prewhit,robust,x,p,hetdat,hetvar);
     disp(['The supF test for 0 versus ' num2str(i) 'breaks (scaled by q) is: ' num2str(ftest(i,1))]) 
  end

  disp('------------------------------------------------')
  for j=1:4
     cv=getcv1(j,eps1);
     disp(['The critical values at the ' num2str(siglev(j,1)) '% level are (for k=1 to ' num2str(m) '): ' num2str(cv(q,1:m))])
  end

  disp('---------------------------------------------------------')
  disp('b) Dmax tests against an unknown number of breaks')
  disp('---------------------------------------------------------')
  disp(['The UDmax test is: ' num2str(max(ftest))])
     
  for j=1:4
    cvm=getdmax(j,eps1);
    disp(['(the critical value at the ' num2str(siglev(j,1)) '% level is: ' num2str(cvm(q,1)) ')'])
  end
 disp('****************************************************************') 
  
  for j=1:4
    cv=getcv1(j,eps1);
    for i=1:m
     wftest(i,1)=cv(q,1)*ftest(i,1)/cv(q,1);
    end

    disp('--------------------------------------')
    disp(['The WDmax test at the ' num2str(siglev(j,1)) '% level is: ' num2str(max(wftest))])
  end
end  

if dospflp1==1
    % The following calls the procedure that estimates the supF(l+1|l)
    % tests where the first l breaks are taken from the global minimization
    disp('**************************************************************')
    disp('supF(l+1|l) tests using global optimizers under the null')
    disp('----------------------------------------------------------------')
  for i=1:m-1
    [supfl ndat]=spflp1(bigvec,datevec(1:i,i),i+1,y,z,h,q,prewhit,robust,x,p,hetdat,hetvar);
    disp(['The supF(' num2str(i+1) '|' num2str(i) ') test is' num2str(supfl)])
    disp(['It corresponds to a new break at: ' num2str(ndat)])
  end
  disp('***************************************************************')
  
  for j=1:4
    cv=getcv2(j,eps1);
    disp(['The critical values of supF(l+1|l) at the ' num2str(siglev(j,1)) '% level are (for i=1 to ' num2str(m) ' are: ' num2str(cv(q,1:m))])
  end
end

if doorder==1
% The following calls the procedure to estimate the number of breaks using
% the information criteria BIC and LWZ (Liu, Wu and Zidek). It returns the
% two orderes selected.
 disp('*****************************************************************')
 disp('Output from the application of Information criteria')
 disp('---------------------------------------------------------------------')

 if p==0
     zz=z;
 else
     zz=[z x];
 end
 ssrzero=ssrnul(y,zz);
 [mbic mlwz]=order(ssrzero,glob,bigt,m,q);
end
     
if dosequa==1
    % The following section calls the sequential procedure that estimates
    % each break one at a time. It stops when the supF(l+1|l) test is not significant. It returns the number of breaks found and the break dates. Note that it can be used independently of the other procedures, i.e. global minimizers need not be obtained since it used a method to compute the breaks in O(T) operations.
    
   nbreak=zeros(4,1);
   dateseq=zeros(4,m);
   
   for j=1:4
     disp('********************************************************************')
     disp(['Output from the sequential procedure at significance level ' num2str(siglev(j,1)) '%'])  
     disp('-----------------------------------------------------------------------')
     
     [nbr datese]=sequa(m,j,q,h,bigt,robust,prewhit,z,y,x,p,hetdat,hetvar,eps1);
     disp('------------------------------------------------------------')
     disp(['The sequential procedure estimated the number of breaks at: ' num2str(nbr)])
     if nbreak>=1
       disp(['The break dates are: ' num2str(datese)])
     else
     end
     nbreak(j,1)=nbr;
      
     if nbr~=0
       dateseq(j,1:nbreak(j,1))=datese';
     end
   end
end
     
if dorepart==1
    % The following procedure constructs the so-called repartition
    % estimates of the breaks obtained by the sequential method (see Bai
    % (1995), Estimating Breaks one at a time, Econometric Theory, 13,
    % 315-352. It alows estimates that have the same asymptotic
    % distribution as those obtained by global minimization. Otherwise, the
    % output from the procedure "estim" below do not deliver asymptotically
    % correct confidence intervals for the break dates.
         
  reparv=zeros(4,m);
  for j=1:4           
    disp('***********************************************')
    disp(['Output from the repartition procedure for the ' num2str(siglev(j,1)) '% significance level'])

    if nbreak(j,1)==0
        disp('**************************************************')
        disp('The sequential procedure found no break and ')
        disp('the repartition procedure is skipped.')
        disp('**************************************************')
    else
        repartda=preparti(y,z,nbreak(j,1),dateseq(j,1:nbreak(j,1))',h,x,p);
        reparv(j,1:nbreak(j,1))=repartda';
    end
  end
end

% The following calls a procedure which estimates the model using as the
% number of breaks the value specified in the first argument. It also calls
% a procedure to calculate standard errors in a way that depends on the
% specification for robust and returns asymptotic confidence intervals for
% the break dates.

if estimbic==1
    disp('******************************************************')
    disp('Output from the estimation of the model selected by BIC')
    disp('------------------------------------------------------------')
    estim(mbic,q,z,y,datevec(:,mbic),robust,prewhit,hetomega,hetq,x,p,hetdat,hetvar)
end
         
if estimlwz==1
    disp('******************************************************')
    disp('Output from the estimation of the model selected by LWZ')
    disp('--------------------------------------------------------------')
    estim(mlwz,q,z,y,datevec(:,mlwz),robust,prewhit,hetomega,hetq,x,p,hetdat,hetvar)
end
         
if estimseq==1
    disp('******************************************************')
    ii=0;
    j=1;
   while j <= 4             
    if ii==0
     if nbreak(j,1)~=0
       disp(['Output from the estimation of the model selected by the sequential method at significance level ' num2str(siglev(j,1)) '%'])
       disp('----------------------------------------------------------')                         
       estim(nbreak(j,1),q,z,y,dateseq(j,1:nbreak(j,1))',robust,prewhit,hetomega,hetq,x,p,hetdat,hetvar);
     end
    end
    
   j=j+1;
    
   if j<=4
     if nbreak(j,1)==nbreak(j-1,1)
       if nbreak(j,1)==0
          disp(['For the ' num2str(siglev(j,1)) '% level, the model is the same as for the ' num2str(siglev(j-1,1)) '% level.'])
          disp('The estimation is not repeated.')
          disp('----------------------------------------------------------')
          ii=1;
       else
           if dateseq(j,1:nbreak(j,1))==dateseq(j-1,1:nbreak(j-1,1));
             disp(['For the ' num2str(siglev(j,1)) '% level, the model is the same as for the ' num2str(siglev(j-1,1)) '% level.'])
             disp('The estimation is not repeated.')
             disp('-------------------------------------------------------')
             ii=1;
           end
       end
     end
   else
       ii=0;
   end
   end
end

                     
if estimrep==1
  ii=0
  disp('*******************************************')
                        
  while j<=4
   if ii==0
    if nbreak(j,1)==0
        disp('***********************')
        disp(['The sequential procedure at the significance level ' num2str(siglev(j,1)) '% found no break and '])
        disp('the repartition procedure was skipped.')
        disp('*******************************************')
    else
        disp('Output from the estimation of the model selected by the')
        disp(['repartition method from the sequential procedure at the significance level' num2str(siglev(j,1)) '%'])
        disp('-------------------------------------------------')
        estim(nbreak(j,1),q,z,y,reparv(j,1:nbreak(j,1))',robust,prewhit,hetomega,hetq,x,p,hetdat,hetvar);
    end
   end

   j=j+1;
   if j<=4
     if nbreak(j,1)==nbreak(j-1,1);
      if nbreak(j,1)==0
       disp(['For the' num2str(siglev(j,1)) '% level, the model is the same as for the ' num2str(siglev(j-1,1)) '% level.'])
       disp('The estimation is not repeated.')
       disp('-----------------------------------------------------')
       ii=1;
      else
        if dateseq(j,1:nbreak(j,1))==dateseq(j-1,1:nbreak(j-1,1))
          disp(['For the ' num2str(siglev(j,1)) '% level, the model is the same as for the ' num2str(siglev(j-1,1)) '% level.'])
          disp('The estimation is not repeated.')
          disp('---------------------------------------------------------')
          ii=1;
        end
    end
  else
   ii=0;
     end
  end
 end
end
                     
if estimfix==1
  disp('**********************************************************')
  disp(['Output from the estimation of the model with ' num2str(fixn) 'breaks'])
  disp('------------------------------------------------------------------')
  estim(fixn,q,z,y,datevec(:,fixn),robust,prewhit,hetomega,hetq,x,p,hetdat,hetvar);
end
