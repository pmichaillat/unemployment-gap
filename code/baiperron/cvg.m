function cvec=cvg(eta,phi1s,phi2s)

cvec=zeros(4,1);
a=phi1s/phi2s;
gam=((phi2s/phi1s)+1)*eta/2;
b=sqrt(phi1s*eta/phi2s);
deld=sqrt(phi2s*eta/phi1s)+b/2;
alph=a*(1+a)/2;
bet=(1+2*a)/2;
sig=[0.025 0.05 0.95 0.975];

isig=1;
while isig <=4
    upb=2000.0;
    lwb=-2000.0;
    crit=999999.0;
    cct=1;
    
    while abs(crit) >= .000001;
        cct=cct+1;
        if cct > 100;
            disp('the procedure to get critical values for the break dates has');
            disp('reached the upper bound on the number of iterations. This may');
            disp('in the procedure cvg. The resulting confidence interval for this');
            disp('break date is incorect');
            break;
        else
            xx=lwb+(upb-lwb)/2;
            pval=funcg(xx,bet,alph,b,deld,gam);
            crit=pval-sig(isig);
            if crit <= 0
                lwb=xx;
            else
                upb=xx;
            end
        end
    end
    cvec(isig,1)=xx;
    
    isig=isig+1;
end
