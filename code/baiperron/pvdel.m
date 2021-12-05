function vdel=pvdel(y,z,i,q,bigt,b,prewhit,robust,x,p,withb,hetdat,hetvar)

% procedure that compute the covariance matrix of the estimates delta.

ev=ones(i+1,1);
zbar=pzbar(z,i,b);

if p==0
    delv=olsqr(y,zbar);
    res=y-zbar*delv;
    reg=zbar;
else
    delv=olsqr(y,[zbar x]);
    res=y-[zbar x]*delv;
    
    if withb==0
        reg=zbar-x*inv(x'*x)*x'*zbar;
    else
        reg=[x zbar];
    end
end

if robust==0
    % section on testing with no serial correlation in errors
    
    if p==0
        if hetdat==1 && hetvar==0
            sig=res'*res/bigt;
            vdel=sig*inv(reg'*reg);
        end
        if hetdat==1 && hetvar==1
            sig=psigmq(res,b,q,i,bigt);
            vdel=kron(sig,eye(q))*inv(reg'*reg);
        end
        if hetdat==0 && hetvar==0
            lambda=plambda(b,i,bigt);
            sig=res'*res/bigt;
            vdel=sig*inv(kron(lambda,(z'*z)));
        end
        if hetdat==0 && hetvar==1
            lambda=plambda(b,i,bigt);
            sig=psigmq(res,b,q,i,bigt);
            vdel=kron(sig,eye(q))*inv(kron(lambda,(z'*z)));
        end
        
    else
        
        if hetdat==0
            disp('the case hetdat=0 is not allowed.');
            disp('vdel is returned as zeros.');
            vdel=zeros(q*(i+1),q*(i+1));
        end
        
        if hetdat==1 && hetvar==0
            sig=res'*res/bigt;
            vdel=sig*inv(reg'*reg);
        end
        
        if hetdat==1 && hetvar==1
            wbar=pzbar(reg,i,b);
            ww=wbar'*wbar;
            sig=psigmq(res,b,q,i,bigt);
            gg=zeros((i+1)*q+p*withb, (i+1)*q+p*withb);
            ie=1;
            while ie<=i+1
                gg=gg+sig(ie,ie)*ww((ie-1)*((i+1)*q+p*withb)+1:ie*((i+1)*q+...
                    p*withb),(ie-1)*((i+1)*q+p*withb)+1:ie*((i+1)*q+p*withb));
                ie=ie+1;
            end
            vdel=inv(reg'*reg)*gg*inv(reg'*reg);
        end
    end
    
else
    if hetdat==0
        disp('the case hetdat=0 is not allowed');
        disp('vdel is returned as zeros.');
        vdel=zeros(q*(i+1),q*(i+1));
    end
    
    if p==0
        if hetvar==1
            hac=zeros((i+1)*q,(i+1)*q);
            vdel=zeros((i+1)*q,(i+1)*q);
            hac(1:q,1:q)=b(1,1)*correct(z(1:b(1,1),:),res(1:b(1,1),1),prewhit);
            for j=2:i
                hac((j-1)*q+1:j*q,(j-1)*q+1:j*q)=(b(j,1)-b(j-1,1))*correct(z(b(j-1,1)+1:b(j,1),:),...
                    res(b(j-1,1)+1:b(j,1),1),prewhit);
            end
            
            hac(i*q+1:(i+1)*q,i*q+1:(i+1)*q)=(bigt-b(i,1))*correct(z(b(i,1)+1:bigt,:),...
                res(b(i,1)+1:bigt,1), prewhit);
            
            vdel=inv(reg'*reg)*hac*inv(reg'*reg);
        else
            hac=correct(z,res,prewhit);
            lambda=plambda(b,i,bigt);
            vdel=bigt*inv(reg'*reg)*kron(lambda,hac)*inv(reg'*reg);
        end
        
    else
        
         hac=correct(reg,res,prewhit);
         vdel=bigt*inv(reg'*reg)*hac*inv(reg'*reg);

        
    end
end

        
            
            