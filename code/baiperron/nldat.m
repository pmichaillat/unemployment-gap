function [glb,datevec,bigvec]=nldat(y,z,x,h,m,p,q,bigt,fixb,eps,maxi,betaini,printd)

glb=zeros(m,1);
globnl=zeros(m,1);
datevec=zeros(m,m);
datenl=zeros(m,m);

mi=1;
while mi <= m
    if printd==1;
        disp('Breaks of model');
        disp(mi);
    end
    
    if fixb==0
        qq=p+q;
        zz=[x z];
        
        [globnl,datenl,bigvec]=dating(y,zz,h,mi,qq,bigt);
        
        xbar=pzbar(x,mi,datenl(1:mi,mi));
        zbar=pzbar(z,mi,datenl(1:mi,mi));
        teta=olsqr(y,[zbar xbar]);
        delta1=teta(1:q*(mi+1),1);
        beta1=olsqr(y-zbar*delta1,x);
        
        % Calculate SSR
        ssr1=(y-x*beta1-zbar*delta1)'*(y-x*beta1-zbar*delta1);
        
        if printd==1
            disp('The iterations are initialized with;');
            disp('Break date');
            disp(delta1);
            disp(beta1);
        end
    else
        beta1=betaini;
        ssr1=-5;
    end
    
    % Starting the iterations.
    if printd==1
        disp('Output from the iterations');
    end

    length=99999999.0;
    i=1;
    
    while length > eps
        
        [globnl,datenl,bigvec]=dating(y-x*beta1,z,h,mi,q,bigt);
        
        zbar=pzbar(z,mi,datenl(1:mi,mi));
        teta1=olsqr(y,[x zbar]);
        beta1=teta1(1:p,1);
        delta1=teta1(p+1:p+q*(mi+1),1);
        ssrn=(y-[x zbar]*teta1)'*(y-[x zbar]*teta1);
        
        % Calculate overall SRR and check if significantly smaller.
        
        length=abs(ssrn-ssr1);
        
        if printd==1
            disp('Iteration');
        end
        
        if i >= maxi
            disp('The number of iterations has reached the upper limit');
        else
            i=i+1;
            ssr1=ssrn;
            glb(mi,1)=ssrn;
            datevec(1:mi,mi)=datenl(1:mi,mi);
        end
        
    end
    mi=mi+1;
end
