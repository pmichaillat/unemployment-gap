function [nbreak,dv0]=sequa(m,signif,q,h,bigt,robust,prewhit,z,y,x,p,hetdat,hetvar,eps1)

% This procedure applies the sequential procedure to obtain the number of
% breaks and the break dates. The current version only allows pure
% structural changes. This will be generalized.
% Here m is the maximum number of breaks allowed.
                        
dv=zeros(m+2,1);
dv2=zeros(m+2,1);
ftestv=zeros(m+1,1);

cv=getcv2(signif,eps1);
dv(1,1)=0;

if p==0
    vssrev=ssr(1,rot90(rot90(y)),rot90(rot90(z)),h,bigt);
    vssr=ssr(1,y,z,h,bigt);
    [ssrmin,datx]=partione(h,bigt-h,bigt,vssr,vssrev);
else
    [ssrmin,datx]=onebp(y,z,x,h,1,bigt);
end

dv(2,1)=datx;

ftest=pftest(y,z,1,q,bigt,dv(2,1),prewhit,robust,x,p,hetdat,hetvar);

if ftest < cv(q,1)
    nbreak=0;
    dv(2,1)=0;
    dv0=dv(2:nbreak+1,1);
    nseg=1;
else
    disp(['The first break found is at: ' num2str(datx)]);
    nbreak=1;
    nseg=2;
    dv(nseg+1,1)=bigt;
end

while nseg <= m
    ds=zeros(nseg+1,1);
    ftestv=zeros(nseg+1,1);
    
    is=1;
    
    while is <= nseg
        length=dv(is+1,1)-dv(is,1);
        
        if length >= 2*h
            
            if p==0
                vssr=ssr(1,y(dv(is,1)+1:dv(is+1,1),1),...
                    z(dv(is,1)+1:dv(is+1,1),:),h,length);
                vssrev=ssr(1,rot90(rot90(y(dv(is,1)+1:dv(is+1,1),1))),...
                    rot90(rot90(z(dv(is,1)+1:dv(is+1,1),:))),h,length);
                [dum,ds(is,1)]=partione(h,length-h,length,vssr,vssrev);
                ftestv(is,1)=pftest(y(dv(is,1)+1:dv(is+1,1),1),...
                    z(dv(is,1)+1:dv(is+1,1),:),1,q,length,ds(is,1),...
                    prewhit,robust,0,p,hetdat,hetvar);
            else
                [dum,ds(is,1)]=onebp(y,z,x,h,dv(is,1)+1,dv(is+1,1));
                ds(is,1)=ds(is,1)-dv(is,1);
                ftestv(is,1)=pftest(y(dv(is,1)+1:dv(is+1,1),1),...
                    z(dv(is,1)+1:dv(is+1,1),:),1,q,length,ds(is,1),...
                    prewhit,robust,x(dv(is,1)+1:dv(is+1,1),:),p,hetdat,hetvar);
            end
            
        else
            ftestv(is,1)=0.0;
        end
        
        is=is+1;
    end
    
    maxf=max(ftestv(1:nseg,1));
    
    if maxf < cv(q,nseg)
        nbreak=nbreak;
        dv0=dv(2:nbreak+1,1);
    else
        [dum,newseg]=max(ftestv(1:nseg,1));
        disp(['The next break found is at: ' num2str(ds(newseg,1)+dv(newseg,1))]);
        
        dv(nseg+2,1)=ds(newseg,1)+dv(newseg,1);
        nbreak=nbreak+1;
        dv2=sort(dv(2:nseg+2,1));
        dv(1,1)=0;
        dv(2:nseg+2,1)=dv2;
    end
    
    nseg=nseg+1;
end

disp(['The sequential procedure has reached the upper limit'])

dv0=dv(2:nbreak+1,1);
