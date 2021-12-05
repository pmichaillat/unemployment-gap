function bound=interval(y,z,zbar,b,q,m,robust,prewhit,hetomega,hetq,x,p)

% procedure that computes confidence intervals for the break dates based on
% the "shrinking shifts" asymptotic framework.

cvf=zeros(4,1);
nt=size(z,1);

if p==0
    delta=olsqr(y,zbar);
    res=y-zbar*delta;
else
    dbdel=olsqr(y,[zbar x]);
    res=y-[zbar x]*dbdel;
    delta=dbdel(1:(m+1)*q,1);
end
bound=zeros(m,4);

bf=zeros(m+2,1);
bf(1,1)=0;
bf(2:m+1,1)=b(1:m,1);
bf(m+2,1)=nt;

for i=1:m
    delv=delta(i*q+1:(i+1)*q,1)-delta((i-1)*q+1:i*q,1);
    
    if robust==0
        if hetq==1
            
            qmat=z(bf(i,1)+1:bf(i+1,1),:)'*z(bf(i,1)+1:bf(i+1,1),:)...
                /(bf(i+1,1)-bf(i,1));
            qmat1=z(bf(i+1,1)+1:bf(i+2,1),:)'*z(bf(i+1,1)+1:bf(i+2,1),:)...
                /(bf(i+2,1)-bf(i+1,1));
            
        else
            qmat=z'*z/nt;
            qmat1=qmat;
        end
        
        if hetomega==1
            
            phi1s=res(bf(i,1)+1:bf(i+1,1),1)'*res(bf(i,1)+1:bf(i+1,1),1)...
                /(bf(i+1,1)-bf(i,1));
            phi2s=res(bf(i+1,1)+1:bf(i+2,1),1)'*res(bf(i+1,1)+1:bf(i+2,1),1)...
                /(bf(i+2,1)-bf(i+1,1));
        
        else
            
            phi1s=res'*res/nt;
            phi2s=phi1s;
            
        end
        
        eta=delv'*qmat1*delv/(delv'*qmat*delv);
        
        cvf=cvg(eta,phi1s,phi2s);
        
        %disp('------------------------------------------')
        %disp('The critical values for the construction of the confidence')
        %disp(['intervals for the ' num2str(i) 'th break are (2.5%, 5%, 95%, 97.5%): '])
        %disp(num2str(cvf'))
        
        a=(delv'*qmat*delv)/phi1s;
        
        bound(i,1)=b(i,1)-cvf(4,1)/a;
        bound(i,2)=b(i,1)-cvf(1,1)/a;
        bound(i,3)=b(i,1)-cvf(3,1)/a;
        bound(i,4)=b(i,1)-cvf(2,1)/a;
        
    else
        
        if hetq==1
            
            qmat=z(bf(i,1)+1:bf(i+1,1),:)'*z(bf(i,1)+1:bf(i+1,1),:)...
                /(bf(i+1,1)-bf(i,1));
            qmat1=z(bf(i+1,1)+1:bf(i+2,1),:)'*z(bf(i+1,1)+1:bf(i+2,1),:)...
                /(bf(i+2,1)-bf(i+1,1));
            
        else
            
            qmat=z'*z/nt;
            qmat1=qmat;
        end
        
        if hetomega==1
            
            omega=correct(z(bf(i,1)+1:bf(i+1,1),:), res(bf(i,1)+1:bf(i+1,1),1),prewhit);
            omega1=correct(z(bf(i+1,1)+1:bf(i+2,1),:), res(bf(i+1,1)+1:bf(i+2,1),1),prewhit);
            
        else
            
            omega=correct(z,res,prewhit);
            omega1=omega;
            
        end
        
        phi1s=delv'*omega*delv/(delv'*qmat*delv);
        phi2s=delv'*omega1*delv/(delv'*qmat*delv);
        
        eta=delv'*qmat1*delv/(delv'*qmat*delv);
        
        cvf=cvg(eta,phi1s,phi2s);
        
        %disp('------------------------------------------')
        %disp('The critical values for the construction of the confidence')
        %disp(['intervals for the ' num2str(i) 'th break are (2.5%, 5%, 95%, 97.5%): '])
        %disp(num2str(cvf'))
        
        a=(delv'*qmat*delv)^2/(delv'*omega*delv);
        
        bound(i,1)=b(i,1)-cvf(4,1)/a;
        bound(i,2)=b(i,1)-cvf(1,1)/a;
        bound(i,3)=b(i,1)-cvf(3,1)/a;
        bound(i,4)=b(i,1)-cvf(2,1)/a;
    end
    
    bound(:,1)=round(bound(:,1));
    bound(:,2)=round(bound(:,2))+1;
    bound(:,3)=round(bound(:,3));
    bound(:,4)=round(bound(:,4))+1;
    
end
    
    
        
        
        
    