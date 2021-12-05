function [ssrind,bd]=onebp(y,z,x,h,start,last)

% procedure that computes an optimal one break partition in the case of a
% partial structural by searching over all possible breaks.

ssrind=9999999999;
i=h;

while i <= last-start+1-h
    zb=pzbar(z(start:last,:),1,i);
    bb=olsqr(y(start:last,1),[x(start:last,:) zb]);
    rr=(y(start:last,1)-[x(start:last,:) zb]*bb)'...
        *(y(start:last,:)-[x(start:last,:) zb]*bb);
    
        if rr < ssrind
            ssrind=rr;
            bdat=i;
        end
    i=i+1;
end

bd=bdat+start-1;