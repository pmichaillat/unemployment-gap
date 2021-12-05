function dr=preparti(y,z,nbreak,dateseq,h,x,p)

% procedure that constructs modified sequential estimates using the
% repartition method of Bai (1995), Estimating Breaks one at a time.
bigt=size(z,1);
q=size(z,2);

dv=zeros(nbreak+2,1);

dv(1,1)=0;
dv(2:nbreak+1,1)=dateseq;

dv(nbreak+2,1)=bigt;
ds=zeros(nbreak,1);
dr=zeros(nbreak,1);

for is=1:nbreak
    
    length=dv(is+2,1)-dv(is,1);
    
    if p==0
        vssr=ssr(1,y(dv(is,1)+1:dv(is+2,1),1),...
            z(dv(is,1)+1:dv(is+2,1),:),h,length);
        vssrev=ssr(1,rot90(rot90(y(dv(is,1)+1:dv(is+2,1),1) )),...
            rot90(rot90(z(dv(is,1)+1:dv(is+2,1),:))),h,length);
        [dummy ds(is,1)]=partione(h,length-h,length,vssr,vssrev);
        dr(is,1)=ds(is,1)+dv(is,1);
    else
        [dummy ds(is,1)]=onebp(y,z,x,h,dv(is,1)+1,dv(is+2,1));
        dr(is,1)=ds(is,1);
    end
    
end
