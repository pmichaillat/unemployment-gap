function [glb datevec bigvec]=dating(y,z,h,m,q,bigt)

% This is the main procedure which calculates the break points that globally
% minimizes the SSR. It returns optiomal dates and associated SSR for all
% numbers of breaks less than or equal to m.

datevec=zeros(m,m);
optdat=zeros(bigt,m);
optssr=zeros(bigt,m);
dvec=zeros(bigt,1);
glb=zeros(m,1);
bigvec=zeros(bigt*(bigt+1)/2,1);

for i=1:bigt-h+1
    vecssr=ssr(i,y,z,h,bigt);
    bigvec((i-1)*bigt+i-(i-1)*i/2:i*bigt-(i-1)*i/2,1)=vecssr(i:bigt,1);
end

if m==1
    [ssrmin,datx]=parti(1,h,bigt-h,bigt,bigvec,bigt);
    datevec(1,1)=datx;
    glb(1,1)=ssrmin;
else
    
    for j1=2*h:bigt
        [ssrmin, datx]=parti(1,h,j1-h,j1,bigvec,bigt);
        optssr(j1,1)=ssrmin;
        optdat(j1,1)=datx;
    end
    glb(1,1)=optssr(bigt,1);
    datevec(1,1)=optdat(bigt,1);
    
    for ib=2:m
        if ib==m
            jlast=bigt;
            for jb=ib*h:jlast-h
                dvec(jb,1)=optssr(jb,ib-1)+bigvec((jb+1)*bigt-jb*(jb+1)/2,1);
            end
            optssr(jlast,ib)=min(dvec(ib*h:jlast-h,1))';
            [dummy, minindcdvec]=min(dvec(ib*h:jlast-h,1));
            optdat(jlast,ib)=(ib*h-1)+minindcdvec';
            
        else
            
            for jlast=(ib+1)*h:bigt
                for jb =ib*h: jlast-h
                    dvec(jb,1)=optssr(jb,ib-1)+bigvec(jb*bigt-jb*(jb-1)/2+jlast-jb,1);
                end
                optssr(jlast,ib)=min(dvec(ib*h:jlast-h,1));
                [dummy,minindcdvec]=min(dvec(ib*h:jlast-h,1));
                optdat(jlast,ib)=(ib*h-1)+minindcdvec';
            end
        end
       
        datevec(ib,ib)=optdat(bigt,ib);
        
        for i=1:ib-1
            xx=ib-i;
            datevec(xx,ib)=optdat(datevec(xx+1,ib),xx);
        end
        glb(ib,1)=optssr(bigt,ib);
    end
end

    