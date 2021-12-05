function [maxf, newd]=spflp1(bigvec,dt,nseg,y,z,h,q,prewhit,robust,x,p,hetdat,hetvar)

% procedure that computes the supF(l+1|l) test l=nseg-1. The l breaks under
% the null are taken from the global minimization (in dt).

ssr=zeros(nseg,1);
ftestv=zeros(nseg,1);
bigt=size(z,1);
ftestv=zeros(nseg,1);
dv=zeros(nseg+1,1);
dv(2:nseg,1)=dt;
dv(nseg+1,1)=bigt;
ds=zeros(nseg,1);

in=0;

for is=1:nseg
    length=dv(is+1,1)-dv(is,1);
    
    if length >= 2*h
        if p==0
            [ssr(is,1), ds(is,1)]=parti(dv(is,1)+1,...
                dv(is,1)+h,dv(is+1,1)-h,dv(is+1,1),bigvec,bigt);
            ftestv(is,1)=pftest(y(dv(is,1)+1:dv(is+1,1),1), z(dv(is,1)+1:dv(is+1,1),:),...
                1,q,length,ds(is,1)-dv(is,1),prewhit,robust,0,p,hetdat,hetvar);
        else
            [ssr(is,1), ds(is,1)]=onebp(y,z,x,h,dv(is,1)+1,dv(is+1,1));
            ftestv(is,1)=pftest(y(dv(is,1)+1:dv(is+1,1),1), z(dv(is,1)+1:dv(is+1,1),:),...
                1,q,length,ds(is,1)-dv(is,1),prewhit,robust,x(dv(is,1)+1:dv(is+1,1),:),...
                p,hetdat,hetvar);
        end
        
    else
        in=in+1;
        ftestv(is,1)=0.0;
    end
end

if in == nseg
    disp(['Given the location of the breaks from the global optimization with ' ...
        num2str(1) ' breaks there was no more place to insert' ...
        ' an additional breaks that satisfy the minimal length requirement.']);
end

[maxf,news]=max(ftestv(1:nseg,1));
newd=ds(news,1);



        
            